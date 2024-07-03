/*
    Copyright 2011-2012 Heikki Holstila <heikki.holstila@gmail.com>

    This work is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This work is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this work.  If not, see <http://www.gnu.org/licenses/>.
*/

#include <QDir>
#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlEngine>
#include <QQuickView>
#include <QScreen>
#include <QString>
// #include <QQmlApplicationEngine>
#include <QCameraInfo>
#include <QStringListModel>
#include <QNetworkInterface>
#include <csignal>
#include <thread>
#include <unistd.h>
#include <sys/stat.h>

#include "include/common.h"
#include "include/appsmenu.h"
#include "include/topbar.h"
#include "include/deviceinfo.h"
#include "include/stats.h"


#include "include/terminal/keyloader.h"
#include "include/terminal/textrender.h"
#include "include/terminal/utilities.h"
#include "include/terminal/version.h"

static void copyFileFromResources(QString from, QString to);

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



int main(int argc, char* argv[])
{
    QStringList modelslist = modelNamesList.stringList();
    fstream modelsfile;
    struct stat sb;

    thread getIpAddrThread(GetIpAddr);
    getIpAddrThread.detach();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    std::signal(SIGINT,  sigHandler);
    std::signal(SIGTERM, sigHandler);

 

    QCoreApplication::setApplicationName("TI Apps Launcher");

    QGuiApplication app(argc, argv);

    QScreen* sc = app.primaryScreen();
    if (sc) {
        sc->setOrientationUpdateMask(Qt::PrimaryOrientation
            | Qt::LandscapeOrientation
            | Qt::PortraitOrientation
            | Qt::InvertedLandscapeOrientation
            | Qt::InvertedPortraitOrientation);
    }

    qmlRegisterType<TextRender>("literm", 1, 0, "TextRender");
    qmlRegisterUncreatableType<Util>("literm", 1, 0, "Util", "Util is created by app");
    QQuickView view;

    bool fullscreen = app.arguments().contains("-fullscreen");

    QSize screenSize = QGuiApplication::primaryScreen()->size();

    if (fullscreen) {
        view.setWidth(screenSize.width());
        view.setHeight(screenSize.height());
    } else {
        view.setWidth(screenSize.width() / 2);
        view.setHeight(screenSize.height() / 2);
    }

    QString settings_path(QDir::homePath() + "/.config/literm");
    QDir dir;

    if (!dir.exists(settings_path)) {
        // Migrate FingerTerm settings if present
        QString old_settings_path(QDir::homePath() + "/.config/FingerTerm");
        if (dir.exists(old_settings_path)) {
            if (!dir.rename(old_settings_path, settings_path))
                qWarning() << "Could not migrate FingerTerm settings path" << old_settings_path << "to" << settings_path;
        } else if (!dir.mkdir(settings_path))
            qWarning() << "Could not create literm settings path" << settings_path;
    }

    QString settingsFile = settings_path + "/settings.ini";

    Util util(settingsFile);
    qmlRegisterSingletonInstance("literm", 1, 0, "Util", &util);

    QString startupErrorMsg;

    // copy the default config files to the config dir if they don't already exist
    copyFileFromResources(":/assets/data/menu.xml", util.configPath() + "/menu.xml");
    copyFileFromResources(":/assets/data/english.layout", util.configPath() + "/english.layout");
    copyFileFromResources(":/assets/data/finnish.layout", util.configPath() + "/finnish.layout");
    copyFileFromResources(":/assets/data/french.layout", util.configPath() + "/french.layout");
    copyFileFromResources(":/assets/data/german.layout", util.configPath() + "/german.layout");
    copyFileFromResources(":/assets/data/qwertz.layout", util.configPath() + "/qwertz.layout");

    KeyLoader keyLoader;
    keyLoader.setUtil(&util);
    qmlRegisterSingletonInstance("literm", 1, 0, "KeyLoader", &keyLoader);
    bool ret = keyLoader.loadLayout(util.keyboardLayout());
    if (!ret) {
        // on failure, try to load the default one (english) directly from resources
        startupErrorMsg = "There was an error loading the keyboard layout.<br>\nUsing the default one instead.";
        util.setKeyboardLayout("english");
        ret = keyLoader.loadLayout(":/assets/data/english.layout");
        if (!ret)
            qFatal("failure loading keyboard layout");
    }

    util.setWindow(&view);

    QObject::connect(view.engine(), SIGNAL(quit()), &app, SLOT(quit()));

    // Allow overriding the UX choice
    QString uxChoice;
    if (app.arguments().contains("-mobile"))
        uxChoice = "mobile";
    else if (app.arguments().contains("-desktop"))
        uxChoice = "desktop";

    if (uxChoice.isEmpty()) {
        uxChoice = "desktop";
    }

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
    view.engine()->rootContext()->setContextProperty("modelNamesList", &modelNamesList);
    view.engine()->rootContext()->setContextProperty("appsmenu", &appsmenu);
    view.engine()->rootContext()->setContextProperty("powermenu", &powermenu);
    view.engine()->rootContext()->setContextProperty("deviceinfo", &deviceinfo);
    view.engine()->rootContext()->setContextProperty("statsbackend", &statsbackend);
    platform_setup(view.engine());
    // view.engine()->load(QUrl(QStringLiteral("qrc:/ti-apps-launcher.qml")));
    // if (view.engine()->rootObjects().isEmpty())
       // return -1;

    view.setResizeMode(QQuickView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:/qml/ti-apps-launcher.qml"));
    view.showFullScreen();

    QObject* root = view.rootObject();
    if (!root)
        qFatal("no root object - qml error");

    if (fullscreen) {
        view.showFullScreen();
    } else {
        view.show();
    }


    return app.exec();
}

static void copyFileFromResources(QString from, QString to)
{
    // copy a file from resources to the config dir if it does not exist there
    QFileInfo toFile(to);
    if (!toFile.exists()) {
        QFile newToFile(toFile.absoluteFilePath());
        QResource res(from);
        if (newToFile.open(QIODevice::WriteOnly)) {
            newToFile.write(reinterpret_cast<const char*>(res.data()));
            newToFile.close();
        } else {
            qWarning() << "Failed to copy default config from resources to" << toFile.filePath();
        }
    }
}
