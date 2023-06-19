#include <QObject>
#include <iostream>
#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include "includes/common.h"
#include "includes/appsmenu.h"

extern int include_apps_count;
extern app_info include_apps[];

int apps_menu::button_getcount(){
    return include_apps_count;
}

QString apps_menu::button_getname(int n) {
    return include_apps[n].name;
}

QString apps_menu::button_getqml(int n) {
    return include_apps[n].qml_source;
}

QString apps_menu::button_geticon(int n) {
    return include_apps[n].icon_source;
}
