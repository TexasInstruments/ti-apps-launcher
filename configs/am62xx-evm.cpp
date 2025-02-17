/* Configuration file for AM62x and AM62x-LP */

#include "backend/includes/common.h"

#include "config_common.h"

using namespace std;
static QString platform = "am62xx-evm";
static QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

static power_actions include_powerbuttons[] = {
    action_shutdown,
    action_reboot,
#if RT_BUILD == 0
    action_suspend,
#endif
};

static app_info include_apps[] = {
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
};

struct device_info device_info_am62 = {
    .dtMatchString = "AM625 SK",
    .platform = platform,
    .wallpaper = wallpaper,
    .include_apps = include_apps,
    .include_apps_count = ARRAY_SIZE(include_apps),
    .include_powerbuttons = include_powerbuttons,
    .include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons),
};
