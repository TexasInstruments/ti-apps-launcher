#include "includes/common.h"
#include "includes/topbar.h"

int power_menu::button_getcount(){
    return deviceMap[detected_device].include_powerbuttons.size();
}

QString power_menu::button_getcommand(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].command;
}

QStringList power_menu::button_getargs(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].args;
}

QString power_menu::button_getname(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].name;
}

QString power_menu::button_geticon(int n) {
    return deviceMap[detected_device].include_powerbuttons[n].icon_source;
}
