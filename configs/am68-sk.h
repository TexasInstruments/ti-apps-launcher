/* Configuration file for AM68 SK*/

#include "backend/includes/common.h"

using namespace std;
static QString platform = "am68-sk";
static QString wallpaper = "/images/am6x_oob_demo_home_image.png";

struct device_info device_info_am68 = {
    .dtMatchString = "J721S2",
    .platform = "am68-sk",
    .wallpaper = "/images/am6x_oob_demo_home_image.png",
    .include_apps = {
        app_industrial_control,
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
    },
};
