/* Configuration file for AM62x SIP EVM */

#include <iostream>
#include "include/common.h"
#include "include/live_camera.h"
#include "include/run_cmd.h"
#include "include/settings.h"
#include "include/gpu_performance.h"
#include "include/benchmarks.h"

#define PLATFORM "am62xxsip-evm"
using namespace std;
QString platform = "am62xxsip-evm";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am62sip_wallpaper.png";

int include_powerbuttons_count = 2;
power_actions include_powerbuttons[] = {
    {
        .name = "Shutdown",
        .command = "shutdown now",
        .icon_source = "file:///opt/ti-apps-launcher/assets/shutdown.png",
    },
    {
        .name = "Reboot",
        .command = "reboot",
        .icon_source = "file:///opt/ti-apps-launcher/assets/reboot.png",
    }
};

int include_apps_count = 4;
app_info include_apps[] = {
    {
        .qml_source = "industrial_control_minimal.qml",
        .name = "Industrial HMI",
        .icon_source = "file:///opt/ti-apps-launcher/assets/hmi.png"
    },
    {
        .qml_source = "live_camera.qml",
        .name = "Live Camera",
        .icon_source = "file:///opt/ti-apps-launcher/assets/camera.png"
    },
    {
        .qml_source = "terminal/terminal.qml",
        .name = "Terminal",
        .icon_source = "file:///opt/ti-apps-launcher/assets/terminal.png"
    },
    {
        .qml_source = "settings.qml",
        .name = "Settings",
        .icon_source = "file:///opt/ti-apps-launcher/assets/settings.png"
    }
};

Settings settings;
LiveCamera live_camera;
Benchmarks benchmarks;
Gpu_performance gpuperformance;

RunCmd *poweraction = new RunCmd(QStringLiteral(""));

void platform_setup(QQmlEngine *engine) {
    std::cout << "Running Platform Setup of AM62x SIP EVM!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);

    engine->rootContext()->setContextProperty("poweraction", poweraction);
}

