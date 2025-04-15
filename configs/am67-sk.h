/* Configuration file for AM67 SK*/

#include "backend/includes/common.h"

struct device_info device_info_am67 = {
    .dtMatchString = "J722S",
    .platform = "am67-sk",
    .wallpaper = "/images/am6x_oob_demo_home_image.png",
    .include_apps = {
        app_industrial_control_sitara,
        app_live_camera,
        app_benchmarks_jacinto,
        app_gpu_performance,
        app_seva_store,
        app_chromium_browser,
        app_settings,
    },
    .include_powerbuttons = {
        action_shutdown,
        action_reboot,
    },
};
