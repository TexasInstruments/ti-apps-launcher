#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCameraInfo>
#include <QStringListModel>
#include <QNetworkInterface>
#include <csignal>
#include <thread>
#include <unistd.h>
#include <sys/stat.h>
#include "backend/includes/common.h"
#include "backend/includes/appsmenu.h"
#include "backend/includes/topbar.h"
#include "backend/includes/deviceinfo.h"
#include "backend/includes/stats.h"
QStringListModel modelNamesList;

//objects 
stats statsbackend;
apps_menu appsmenu;
power_menu powermenu;
Device_info deviceinfo;
/*
__attribute__((weak)) void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "No platform setup needed!" << endl;
}
*/

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
                        deviceinfo.set_ip_addr("IP Addr: " + address.ip().toString());
                        emit deviceinfo.ip_addr_changed();
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
    // cout << PLATFORM << endl;
    QApplication app(argc, argv);

    QStringList modelslist = modelNamesList.stringList();
    fstream modelsfile;
    struct stat sb;

    thread getIpAddrThread(GetIpAddr);
    getIpAddrThread.detach();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    std::signal(SIGINT,  sigHandler);
    std::signal(SIGTERM, sigHandler);

    QQmlApplicationEngine engine;

    // Get and Populate contents of /opt/oob-demo-assets/allowedModels.txt to modelNamesList
    // Add the model to list only if it's available in the filesystem
    modelsfile.open("/opt/oob-demo-assets/allowedModels.txt",ios::in);
    if (modelsfile.is_open()) {
        string model;
        while(getline(modelsfile, model)) {
            string dir = "/opt/model_zoo/";
            if (stat((dir + model).c_str(), &sb) == 0)
                modelslist.append(QString::fromStdString(model));
        }
        modelsfile.close();
    }
    modelNamesList.setStringList(modelslist);

    // set context properties to access in QML
    engine.rootContext()->setContextProperty("modelNamesList", &modelNamesList);
    engine.rootContext()->setContextProperty("appsmenu", &appsmenu);
    engine.rootContext()->setContextProperty("powermenu", &powermenu);
    engine.rootContext()->setContextProperty("deviceinfo", &deviceinfo);
    engine.rootContext()->setContextProperty("statsbackend", &statsbackend);
    platform_setup(&engine);
    engine.load(QUrl(QStringLiteral("qrc:/ti-apps-launcher.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
