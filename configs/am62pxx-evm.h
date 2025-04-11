/* Configuration file for AM62Px */

#include "backend/includes/common.h"

struct device_info device_info_am62p = {
    .dtMatchString = "AM62P5 SK",
    .platform = "am62pxx-evm",
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
        app_wifi,
    },
    .include_powerbuttons = {
        action_shutdown,
        action_reboot,
    #if RT_BUILD == 0
        action_suspend,
    #endif
    },
};
