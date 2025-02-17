/* Configuration file for AM62x SIP EVM */

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/live_camera.h"
#include "backend/includes/run_cmd.h"
#include "backend/includes/settings.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/benchmarks.h"

#include "config_common.h"

using namespace std;
QString platform = "am62xxsip-evm";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am62sip_wallpaper.png";

power_actions include_powerbuttons[] = {
    action_shutdown,
    action_reboot,
};
int include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons);

app_info include_apps[] = {
    app_industrial_control_minimal,
    app_live_camera,
    app_settings,
    app_terminal,
};
int include_apps_count = ARRAY_SIZE(include_apps);

Settings settings;
LiveCamera live_camera;
Benchmarks benchmarks;
Gpu_performance gpuperformance;

RunCmd *poweraction = new RunCmd(QStringLiteral(""));

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM62x SIP EVM!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);

    engine->rootContext()->setContextProperty("poweraction", poweraction);
}

