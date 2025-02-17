/* Configuration file for AM62x and AM62x-LP */

#include "backend/includes/common.h"

struct device_info device_info_am62 = {
    .dtMatchString = "AM625 SK",
    .platform = "am62xx-evm",
    .wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png",
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
