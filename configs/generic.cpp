/* Configuration file for Generic/Unknown Devices */

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/settings.h"

using namespace std;
QString platform = "generic";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

int include_powerbuttons_count = 0;
power_actions include_powerbuttons[] = {};

int include_apps_count = 2;
app_info include_apps[] = {
    {
        .qml_source = "industrial_control.qml",
        .name = "Industrial HMI",
        .icon_source = "file:///opt/ti-apps-launcher/assets/hmi.png"
    },
    {
        .qml_source = "benchmarks.qml",
        .name = "Benchmarks",
        .icon_source = "file:///opt/ti-apps-launcher/assets/benchmarks.png"
    },
};

Settings settings;

void platform_setup(QQmlApplicationEngine *engine) {
    cout << "Running generic platform setup!" << endl;
    engine->rootContext()->setContextProperty("settings", &settings);
}
