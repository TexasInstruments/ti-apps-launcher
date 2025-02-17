/* Configuration file for AM62x SIP EVM */

#include "backend/includes/common.h"

#include "config_common.h"

using namespace std;
static QString platform = "am62xxsip-evm";
static QString wallpaper = "file:///opt/ti-apps-launcher/assets/am62sip_wallpaper.png";

static power_actions include_powerbuttons[] = {
    action_shutdown,
    action_reboot,
};
static app_info include_apps[] = {
    app_industrial_control_minimal,
    app_live_camera,
    app_settings,
    app_terminal,
};

struct device_info device_info_am62sip = {
    .dtMatchString = "AM62xSIP",
    .platform = platform,
    .wallpaper = wallpaper,
    .include_apps = include_apps,
    .include_apps_count = ARRAY_SIZE(include_apps),
    .include_powerbuttons = include_powerbuttons,
    .include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons),
};
