/* Configuration file for AM68 SK*/

#include "backend/includes/common.h"

#include "config_common.h"

using namespace std;
static QString platform = "am68-sk";
static QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

static power_actions include_powerbuttons[] = {
    action_shutdown,
    action_reboot,
};
static app_info include_apps[] = {
    app_industrial_control,
    app_camera,
    app_benchmarks_jacinto,
    app_gpu_performance,
    app_seva_store,
    app_chromium_browser,
    app_settings,
};

struct device_info device_info_am68 = {
    .dtMatchString = "J721S2",
    .platform = platform,
    .wallpaper = wallpaper,
    .include_apps = include_apps,
    .include_apps_count = ARRAY_SIZE(include_apps),
    .include_powerbuttons = include_powerbuttons,
    .include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons),
};
