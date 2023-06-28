/* Configuration file for AM62x and AM62x-LP */

#include <iostream>
#include "../backend/includes/common.h"
//#include "../backend/includes/live_camera.h"
#include "../backend/includes/seva_store.h"
#include "../backend/includes/settings.h"
#include "../backend/includes/stats.h"
#define PLATFORM "am62xx-evm"
using namespace std;
int include_apps_count = 4;
QString platform = "am62xx-evm";

app_info include_apps[] = {
    {
        .qml_source = "industrial_control.qml",
        .name = "Industrial HMI",
        .icon_source = "hmi.png"
    },
    //{
    //    .qml_source = "live_camera.qml",
    //    .name = "Live Camera",
    //    .icon_source = "camera.png"
    //},
    {
        .qml_source = "benchmarks.qml",
        .name = "Benchmarks",
        .icon_source = "benchmarks.png"
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

SevaStore *seva_store = new SevaStore(QStringLiteral("seva-launcher-aarch64"));
SevaStore *firefox_browser = new SevaStore(QStringLiteral("docker run -v ${XDG_RUNTIME_DIR}:/tmp/ -i --env XDG_RUNTIME_DIR=/tmp/ --env WAYLAND_DISPLAY=wayland-1 -u user 6dbd110907bb"));
stats statsbackend;
//LiveCamera live_camera;
Settings settings;

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM62x!" << endl;
    //engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("firefox_browser", firefox_browser);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("statsbackend", &statsbackend);
}

