/* Configuration file for Generic/Unknown Devices */

#include "backend/includes/common.h"

struct device_info device_info_generic = {
    .dtMatchString = "",
    .platform = "generic",
    .wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png",
    .include_apps = {
        app_industrial_control,
        app_benchmarks,
    },
    .include_powerbuttons = {},
};
