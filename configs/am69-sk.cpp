/* Configuration file for AM69 SK*/

#include "backend/includes/common.h"

#include "config_common.h"

using namespace std;
static QString platform = "am69-sk";
static QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

static power_actions include_powerbuttons[] = {
    action_shutdown,
    action_reboot,
    action_suspend,
};
static app_info include_apps[] = {
    app_industrial_control_sitara,
    app_camera,
    app_benchmarks_jacinto,
    app_gpu_performance,
    app_seva_store,
    app_chromium_browser,
    app_settings,
};

struct device_info device_info_am69 = {
    .dtMatchString = "AM69 SK",
    .platform = platform,
    .wallpaper = wallpaper,
    .include_apps = include_apps,
    .include_apps_count = ARRAY_SIZE(include_apps),
    .include_powerbuttons = include_powerbuttons,
    .include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons),
};
