/* Configuration file for AM69 SK*/

#include "backend/includes/common.h"

struct device_info device_info_am69 = {
    .dtMatchString = "AM69 SK",
    .platform = "am69-sk",
    .wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png",
    .include_apps = {
        app_industrial_control_sitara,
        app_camera,
        app_benchmarks_jacinto,
        app_gpu_performance,
        app_seva_store,
        app_chromium_browser,
        app_settings,
    },
    .include_powerbuttons = {
        action_shutdown,
        action_reboot,
        action_suspend,
    },
};
