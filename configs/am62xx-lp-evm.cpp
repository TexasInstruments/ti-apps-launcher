/* Configuration file for AM62x and AM62x-LP */

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/live_camera.h"
#include "backend/includes/arm_analytics.h"
#include "backend/includes/run_cmd.h"
#include "backend/includes/settings.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/benchmarks.h"

#define PLATFORM "am62xx-lp-evm"
using namespace std;
int include_apps_count = 8;
QString platform = "am62xx-lp-evm";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

app_info include_apps[] = {
    {
        .qml_source = "industrial_control_sitara.qml",
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
        .qml_source = "firefox_browser.qml",
        .name = "Firefox",
        .icon_source = "file:///opt/ti-apps-launcher/assets/firefox.png"
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
    }
};

Settings settings;
LiveCamera live_camera;
ArmAnalytics arm_analytics;
Benchmarks benchmarks;
Gpu_performance gpuperformance;

QString seva_command = QString::fromStdString("seva-launcher-aarch64");
RunCmd *seva_store = new RunCmd(seva_command);
RunCmd *firefox_browser = new RunCmd(QStringLiteral("docker run -v /run/user/1000/:/tmp/ -i --env http_proxy --env https_proxy --env no_proxy --env XDG_RUNTIME_DIR=/tmp/ --env WAYLAND_DISPLAY=wayland-1 -u user ghcr.io/texasinstruments/seva-browser:v1.0.0 https://www.ti.com/microcontrollers-mcus-processors/arm-based-processors/overview.html"));
RunCmd *demo_3d = new RunCmd(QStringLiteral("/usr/bin/SGX/demos/Wayland/OpenGLESSkinning"));

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM62x LP EVM!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("arm_analytics", &arm_analytics);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("firefox_browser", firefox_browser);
    engine->rootContext()->setContextProperty("demo_3d", demo_3d);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);

    docker_load_images();
}

