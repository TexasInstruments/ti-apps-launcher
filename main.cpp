#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCameraInfo>
#include <QStringListModel>
#include <QNetworkInterface>
#include "Backend.h"

QStringListModel cameraNamesList;
QString ip_addr;

int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Backend backend;

    // Get and Populate CameraInfo to CameraList
    map<string, map<string,string>> cameraInfo;
    backend.getCameraInfo(cameraInfo);

    QStringList list = cameraNamesList.stringList();
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

    // Fetch IP Addr of the target to display at the bottom of the application
    foreach (const QNetworkInterface &netInterface, QNetworkInterface::allInterfaces()) {
        QNetworkInterface::InterfaceFlags flags = netInterface.flags();
        if( (bool)(flags & QNetworkInterface::IsRunning) && !(bool)(flags & QNetworkInterface::IsLoopBack)){
            foreach (const QNetworkAddressEntry &address, netInterface.addressEntries()) {
                if(address.ip().protocol() == QAbstractSocket::IPv4Protocol)
                    ip_addr = "IP Addr: " + address.ip().toString();
            }
        }
    }

    // set context properties to access in QML
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.rootContext()->setContextProperty("cameraNamesList", &cameraNamesList);
    engine.rootContext()->setContextProperty("ip_addr", ip_addr);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
