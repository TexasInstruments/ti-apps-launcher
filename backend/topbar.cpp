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

extern int include_powerbuttons_count;
extern power_actions include_powerbuttons[];

int power_menu::button_getcount(){
    return include_powerbuttons_count;
}

QString power_menu::button_getcommand(int n) {
    return include_powerbuttons[n].command;
}

QString power_menu::button_getname(int n) {
    return include_powerbuttons[n].name;
}

QString power_menu::button_geticon(int n) {
    return include_powerbuttons[n].icon_source;
}

