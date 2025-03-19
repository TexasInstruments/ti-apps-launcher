#include "includes/common.h"
#include "includes/appsmenu.h"

int apps_menu::button_getcount(){
    return deviceMap[detected_device].include_apps.size();
}

QString apps_menu::button_getname(int n) {
    return deviceMap[detected_device].include_apps[n].name;
}

QString apps_menu::button_getqml(int n) {
    return "/apps/" + deviceMap[detected_device].include_apps[n].qml_source;
}

QString apps_menu::button_geticon(int n) {
    return deviceMap[detected_device].include_apps[n].icon_source;
}
