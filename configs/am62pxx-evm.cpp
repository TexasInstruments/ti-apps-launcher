/* Configuration file for AM62x and AM62x-LP */

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/run_cmd.h"
#include "backend/includes/settings.h"
#include "backend/includes/arm_analytics.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/benchmarks.h"

#define PLATFORM "am62pxx-evm"
using namespace std;
int include_apps_count = 10;
QString platform = "am62pxx-evm";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

app_info include_apps[] = {
    {
        .qml_source = "industrial_control_sitara.qml",
        .name = "Industrial HMI",
        .icon_source = "file:///opt/ti-apps-launcher/assets/hmi.png"
    },
    {
        .qml_source = "arm_analytics.qml",
        .name = "ARM Analytics",
        .icon_source = "file:///opt/ti-apps-launcher/assets/analytics.png"
    },
    {
        .qml_source = "codecs.qml",
        .name = "Video Playback",
        .icon_source = "file:///opt/ti-apps-launcher/assets/playbutton.png"
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
        .qml_source = "chromium_browser.qml",
        .name = "Chromium",
        .icon_source = "file:///opt/ti-apps-launcher/assets/chromium.png"
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
Benchmarks benchmarks;
Gpu_performance gpuperformance;
ArmAnalytics arm_analytics;

QString seva_command = QString::fromStdString("seva-launcher-aarch64");
RunCmd *seva_store = new RunCmd(seva_command);
RunCmd *firefox_browser = new RunCmd(QStringLiteral("docker run -v /run/user/1000/:/tmp/ -i --env http_proxy --env https_proxy --env no_proxy --env XDG_RUNTIME_DIR=/tmp/ --env WAYLAND_DISPLAY=wayland-1 -u user ghcr.io/texasinstruments/seva-browser:v1.0.0 https://www.ti.com/microcontrollers-mcus-processors/arm-based-processors/overview.html"));
RunCmd *chromium_browser = new RunCmd(QStringLiteral("su weston -c \"chromium https://webglsamples.org/aquarium/aquarium.html\""));
RunCmd *demo_3d = new RunCmd(QStringLiteral("/usr/bin/SGX/demos/Wayland/OpenGLESSkinning"));

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM62P!" << endl;
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("firefox_browser", firefox_browser);
    engine->rootContext()->setContextProperty("chromium_browser", chromium_browser);
    engine->rootContext()->setContextProperty("demo_3d", demo_3d);
    engine->rootContext()->setContextProperty("arm_analytics", &arm_analytics);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);

    docker_load_images();
}

