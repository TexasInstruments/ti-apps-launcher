/* Configuration file for AM62x SIP EVM */

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/live_camera.h"
#include "backend/includes/settings.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/benchmarks.h"

#define PLATFORM "am62xxsip-evm"
using namespace std;
int include_apps_count = 2;
QString platform = "am62xxsip-evm";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am62sip_wallpaper.png";

app_info include_apps[] = {
    {
        .qml_source = "industrial_control_minimal.qml",
        .name = "Industrial HMI",
        .icon_source = "file:///opt/ti-apps-launcher/assets/hmi.png"
    },
    /*
    {
        .qml_source = "live_camera.qml",
        .name = "Live Camera",
        .icon_source = "file:///opt/ti-apps-launcher/assets/camera.png"
    },
    */
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

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM62x SIP EVM!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);
}

