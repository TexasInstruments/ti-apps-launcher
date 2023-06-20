/* Configuration file for AM62x and AM62x-LP */

#include <iostream>
#include "../backend/includes/common.h"
#include "../backend/includes/live_camera.h"

#define PLATFORM "am62xx-evm"

int include_apps_count = 3;

app_info include_apps[] = {
    {
        .qml_source = "industrial_control.qml",
        .name = "Industrial HMI",
        .icon_source = "hmi.png"
    },
    {
        .qml_source = "live_camera.qml",
        .name = "Live Camera",
        .icon_source = "camera.png"
    },
    {
        .qml_source = "benchmarks.qml",
        .name = "Benchmarks",
        .icon_source = "benchmarks.png"
    },
};

LiveCamera live_camera;
void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM62x!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
}

