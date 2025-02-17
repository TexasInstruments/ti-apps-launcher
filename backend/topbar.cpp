#include <QObject>
#include <cstdlib>
#include <iostream>
#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include "includes/common.h"
#include "includes/topbar.h"

int power_menu::button_getcount(){
    return deviceMap[detected_device].include_powerbuttons.size();
}

QString power_menu::button_getcommand(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].command;
}

QString power_menu::button_getname(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].name;
}

QString power_menu::button_geticon(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].icon_source;
}

