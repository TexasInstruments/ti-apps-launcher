/* Configuration file for Generic/Unknown Devices */

#include "backend/includes/common.h"
#include "backend/includes/benchmarks.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/live_camera.h"
#include "backend/includes/run_cmd.h"
#include "backend/includes/settings.h"

#define PLATFORM "am68-sk"

using namespace std;

QString platform = "am68-sk";
int include_apps_count = 7;

app_info include_apps[] = {
    {
        .qml_source = "industrial_control.qml",
        .name = "Industrial HMI",
        .icon_source = "qrc:/images/hmi.png"
    },
    {
        .qml_source = "benchmarks.qml",
        .name = "Benchmarks",
        .icon_source = "qrc:/images/benchmarks.png"
    },
    {
        .qml_source = "gpu_performance.qml",
        .name = "GPU Performance",
        .icon_source = "qrc:/images/gpu_performance.png"
    },
    {
        .qml_source = "live_camera.qml",
        .name = "Live Camera",
        .icon_source = "qrc:/images/camera.png"
    },
    {
        .qml_source = "seva_store.qml",
        .name = "Seva Store",
        .icon_source = "qrc:/images/seva_store.png"
    },
    {
        .qml_source = "firefox_browser.qml",
        .name = "Firefox",
        .icon_source = "qrc:/images/firefox.png"
    },
    {
        .qml_source = "settings.qml",
        .name = "Settings",
        .icon_source = "qrc:/images/settings.png"
    }
};


Benchmarks benchmarks;
Gpu_performance gpuperformance;
LiveCamera live_camera;
QString seva_command = QString::fromStdString("seva-launcher-aarch64");
RunCmd *seva_store = new RunCmd(seva_command);
RunCmd *firefox_browser = new RunCmd(QStringLiteral("docker run -v /run/user/1000/:/tmp/ -i --env http_proxy --env https_proxy --env no_proxy --env XDG_RUNTIME_DIR=/tmp/ --env WAYLAND_DISPLAY=wayland-1 -u user ghcr.io/texasinstruments/seva-browser:v1.0.0"));
RunCmd *firefox_browser2 = new RunCmd(QStringLiteral("docker run -v /run/user/1000/:/tmp/ -i --env XDG_RUNTIME_DIR=/tmp/ --env WAYLAND_DISPLAY=wayland-1 -u user ghcr.io/texasinstruments/seva-browser:v1.0.0 https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-j721s2/08_06_01_02/exports/docs/devices/J7_Family/linux/Release_Specific_Performance_Guide.html"));
Settings settings;

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM68x!" << endl;
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("firefox_browser", firefox_browser);
    engine->rootContext()->setContextProperty("firefox_browser2", firefox_browser2);
    engine->rootContext()->setContextProperty("settings", &settings);

    docker_load_images();
}

