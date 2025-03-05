#include "includes/common.h"
#include "includes/deviceinfo.h"

QString Device_info::getplatform(){
    return deviceMap[detected_device].platform;
}

QString Device_info::getWallpaper(){
    return deviceMap[detected_device].wallpaper;
}
