/* Configuration file for Generic/Unknown Devices */

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/settings.h"

#include "config_common.h"

using namespace std;
QString platform = "generic";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

power_actions include_powerbuttons[] = {};
int include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons);

app_info include_apps[] = {
    app_industrial_control,
    app_benchmarks,
};
int include_apps_count = ARRAY_SIZE(include_apps);

Settings settings;

void platform_setup(QQmlApplicationEngine *engine) {
    cout << "Running generic platform setup!" << endl;
    engine->rootContext()->setContextProperty("settings", &settings);
}
