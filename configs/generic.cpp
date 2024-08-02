/* Configuration file for Generic/Unknown Devices */

#include <iostream>
#include "include/common.h"
#include "include/run_cmd.h"
#include "include/settings.h"
#include "include/gpu_performance.h"
#include "include/benchmarks.h"

#define PLATFORM "desktop"
using namespace std;
QString platform = "desktop";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

int include_powerbuttons_count = 3;
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
    },
    {
        .name = "Suspend",
        .command = "/opt/ti-apps-launcher/suspend",
        .icon_source = "file:///opt/ti-apps-launcher/assets/suspend.png",
    }
};

int include_apps_count = 5;
app_info include_apps[] = {
    {
        .qml_source = "industrial_control_sitara.qml",
        .name = "Industrial HMI",
        .icon_source = "file:///opt/ti-apps-launcher/assets/hmi.png"
    },
    {
        .qml_source = "benchmarks.qml",
        .name = "Benchmarks",
        .icon_source = "file:///opt/ti-apps-launcher/assets/benchmarks.png"
    },
    {
        .qml_source = "gpu_performance.qml",
        .name = "GPU Performance",
        .icon_source = "file:///opt/ti-apps-launcher/assets/gpu_performance.png"
    },
    {
        .qml_source = "settings.qml",
        .name = "Settings",
        .icon_source = "file:///opt/ti-apps-launcher/assets/settings.png"
    },
    {
        .qml_source = "terminal/terminal.qml",
	.name = "Terminal",
	.icon_source = "file:///opt/ti-apps-launcher/assets/terminal.png"
    }
};

Settings settings;
Benchmarks benchmarks;
Gpu_performance gpuperformance;

RunCmd *poweraction = new RunCmd(QStringLiteral(""));

void platform_setup(QQmlEngine *engine) {
    std::cout << "Running Platform Setup of AM62P!" << endl;
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);

    engine->rootContext()->setContextProperty("poweraction", poweraction);
}

