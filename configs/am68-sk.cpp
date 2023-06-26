/* Configuration file for Generic/Unknown Devices */

#include "../backend/includes/common.h"
#include "backend/includes/camera_recorder.h"
#include "backend/includes/benchmarks.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/stats.h"
#include "../backend/includes/live_camera.h"

#define PLATFORM "am68-sk"

QString platform = "am68-sk";
int include_apps_count = 5;

app_info include_apps[] = {
    {
        .qml_source = "industrial_control.qml",
        .name = "Industrial HMI",
        .icon_source = "hmi.png"
    },
    {
        .qml_source = "camera_old.qml",
        .name = "Camera Recorder",
        .icon_source = "camera.png"
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
};


camera_recorder camrecbackend;
benchmarks benchmarksbackend;
gpu_performance gpuperfbackend;
stats statsbackend;
LiveCamera live_camera;

void platform_setup(QQmlApplicationEngine *engine) {
    engine->rootContext()->setContextProperty("camrecbackend", &camrecbackend);
    engine->rootContext()->setContextProperty("benchmarksbackend", &benchmarksbackend);
    engine->rootContext()->setContextProperty("gpuperfbackend", &gpuperfbackend);
    engine->rootContext()->setContextProperty("statsbackend", &statsbackend);
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    
}

