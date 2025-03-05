/* Configuration file for Beagleplay */

#include "backend/includes/common.h"

struct device_info device_info_beagleplay = {
    .dtMatchString = "BeaglePlay",
    .platform = "beagleplay",
    .wallpaper = "/images/am6x_oob_demo_home_image.png",
    .include_apps = {
        app_industrial_control_sitara,
        app_live_camera,
        app_arm_analytics,
        app_benchmarks,
        app_gpu_performance,
        app_seva_store,
        app_chromium_browser,
        app_3d_demo,
        app_settings,
        app_terminal,
    },
    .include_powerbuttons = {
        action_shutdown,
        action_reboot,
        action_suspend,
    },
};
