#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCameraInfo>
#include <QStringListModel>
#include <QNetworkInterface>
#include <csignal>
#include <thread>
#include <unistd.h>
#include "Backend.h"

QStringListModel cameraNamesList;
QStringListModel modelNamesList;

Backend backend;

void sigHandler(int s)
{
    std::signal(s, SIG_DFL);
    qApp->quit();
}

void GetIpAddr()
{
    // Fetch IP Addr of the target to display at the bottom of the application
    for(int i = 0; i < 10; i++) {
        foreach (const QNetworkInterface &netInterface, QNetworkInterface::allInterfaces()) {
            QNetworkInterface::InterfaceFlags flags = netInterface.flags();
            if( (bool)(flags & QNetworkInterface::IsRunning) && !(bool)(flags & QNetworkInterface::IsLoopBack)){
                foreach (const QNetworkAddressEntry &address, netInterface.addressEntries()) {
                    if(address.ip().protocol() == QAbstractSocket::IPv4Protocol) {
                        backend.set_ip_addr("IP Addr: " + address.ip().toString());
                        emit backend.ip_addr_changed();
                        return;
                    }
                }
            }
        }
        sleep(10);
    }
    return;
}

int main(int argc, char *argv[]) {
    QStringList list = cameraNamesList.stringList();
    QStringList modelslist = modelNamesList.stringList();
    fstream modelsfile;

    thread getIpAddrThread(GetIpAddr);
    getIpAddrThread.detach();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    std::signal(SIGINT,  sigHandler);
    std::signal(SIGTERM, sigHandler);

    QQmlApplicationEngine engine;

    // Get and Populate CameraInfo to CameraList
    map<string, map<string,string>> cameraInfo;
    backend.getCameraInfo(cameraInfo);

    for ( const auto &data : cameraInfo ) {
        for ( const auto &detailedData : data.second )
        {
            if (detailedData.first.find("device") != string::npos)
            {
                string fullName,device;
                device = backend.replaceAll(detailedData.first,"device","");
                device = backend.trimString(device);
                fullName = data.first;
                if (device.length() > 0)
                    fullName += " " + device;
                list.append(QString::fromStdString(fullName));
            }
        }
    }
    cameraNamesList.setStringList(list);

    // Get and Populate contents of /opt/model_zoo/edgeai-gui-app-models.txt to modelNamesList
    modelsfile.open("/opt/model_zoo/edgeai-gui-app-models.txt",ios::in);
    if (modelsfile.is_open()){
        string model;
        while(getline(modelsfile, model)){
            modelslist.append(QString::fromStdString(model));
        }
        modelsfile.close();
    }
    modelNamesList.setStringList(modelslist);

    // set context properties to access in QML
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.rootContext()->setContextProperty("cameraNamesList", &cameraNamesList);
    engine.rootContext()->setContextProperty("modelNamesList", &modelNamesList);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
