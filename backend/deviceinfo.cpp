#include "includes/deviceinfo.h"

extern QString platform;
QString Device_info::getplatform(){
    return platform;
}

extern QString wallpaper;
QString Device_info::getWallpaper(){
    return wallpaper;
}
