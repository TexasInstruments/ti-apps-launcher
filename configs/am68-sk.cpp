/* Configuration file for Generic/Unknown Devices */

#include "../backend/includes/common.h"
#include "backend/includes/benchmarks.h"
#include "backend/includes/gpu_performance.h"
#include "../backend/includes/live_camera.h"
#include "../backend/includes/seva_store.h"
#include "../backend/includes/settings.h"

#define PLATFORM "am68-sk"

using namespace std;

QString platform = "am68-sk";
int include_apps_count = 6;

app_info include_apps[] = {
    {
        .qml_source = "industrial_control.qml",
        .name = "Industrial HMI",
        .icon_source = "hmi.png"
    },
    {
        .qml_source = "benchmarks.qml",
        .name = "Benchmarks",
        .icon_source = "benchmarks.png"
    },
    {
        .qml_source = "gpu_performance.qml",
        .name = "GPU Performance",
        .icon_source = "gpuperformance.png"
    },
    {
        .qml_source = "live_camera.qml",
        .name = "Live Camera",
        .icon_source = "camera.png"
    },
    {
        .qml_source = "seva_store.qml",
        .name = "Seva Store",
        .icon_source = "seva_store.png"
    },
    {
        .qml_source = "firefox_browser.qml",
        .name = "Firefox",
        .icon_source = "firefox.png"
    }
};

Settings settings;
Benchmarks benchmarks;
Gpu_performance gpuperformance;
LiveCamera live_camera;
QString seva_command = QString::fromStdString("seva-launcher-aarch64 -http_proxy=") + settings._https_proxy + QString::fromStdString(" -no_proxy=") + settings._no_proxy;
SevaStore *seva_store = new SevaStore(seva_command);
SevaStore *firefox_browser = new SevaStore(QStringLiteral("docker run -v /run/user/1000/:/tmp/ -i --env XDG_RUNTIME_DIR=/tmp/ --env WAYLAND_DISPLAY=wayland-1 -u user ghcr.io/texasinstruments/seva-browser:v1.0.0"));

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM68x!" << endl;
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("firefox_browser", firefox_browser);
}

