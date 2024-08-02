/* Configuration file for AM62x-LP */

#include <iostream>
#include "include/common.h"
#include "include/live_camera.h"
#include "include/arm_analytics.h"
#include "include/run_cmd.h"
#include "include/settings.h"
#include "include/gpu_performance.h"
#include "include/benchmarks.h"

#define PLATFORM "am62xx-lp-evm"
using namespace std;
QString platform = "am62xx-lp-evm";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

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

int include_apps_count = 10;
app_info include_apps[] = {
    {
        .qml_source = "industrial_control_sitara.qml",
        .name = "Industrial HMI",
        .icon_source = "file:///opt/ti-apps-launcher/assets/hmi.png"
    },
    {
        .qml_source = "live_camera.qml",
        .name = "Live Camera",
        .icon_source = "file:///opt/ti-apps-launcher/assets/camera.png"
    },
    {
        .qml_source = "arm_analytics.qml",
        .name = "ARM Analytics",
        .icon_source = "file:///opt/ti-apps-launcher/assets/analytics.png"
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
        .qml_source = "seva_store.qml",
        .name = "Seva Store",
        .icon_source = "file:///opt/ti-apps-launcher/assets/seva_store.png"
    },
    {
        .qml_source = "chromium_browser.qml",
        .name = "Chromium",
        .icon_source = "file:///opt/ti-apps-launcher/assets/chromium.png"
    },
    {
        .qml_source = "3d_demo.qml",
        .name = "3D Demo",
        .icon_source = "file:///opt/ti-apps-launcher/assets/3d.png"
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
LiveCamera live_camera;
ArmAnalytics arm_analytics;
Benchmarks benchmarks;
Gpu_performance gpuperformance;

RunCmd *seva_store = new RunCmd(QStringLiteral("su weston -c \"chromium --no-first-run http://localhost:8000/#/\""));
RunCmd *demo_3d = new RunCmd(QStringLiteral("/usr/bin/SGX/demos/Wayland/OpenGLESSkinning"));
RunCmd *poweraction = new RunCmd(QStringLiteral(""));
RunCmd *chromium_browser = new RunCmd(QStringLiteral("su weston -c \"chromium --no-first-run https://webglsamples.org/aquarium/aquarium.html\""));

void platform_setup(QQmlEngine *engine) {
    std::cout << "Running Platform Setup of AM62x LP EVM!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("arm_analytics", &arm_analytics);
    engine->rootContext()->setContextProperty("chromium_browser", chromium_browser);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("demo_3d", demo_3d);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);

    engine->rootContext()->setContextProperty("poweraction", poweraction);
}

