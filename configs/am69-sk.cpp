/* Configuration file for Generic/Unknown Devices */

#include "../backend/includes/common.h"
#include "backend/includes/camera_recorder.h"
#include "backend/includes/benchmarks.h"
#include "backend/includes/gpu_performance.h"

#define PLATFORM "am69-sk"

QString platform = "am69-sk";
int include_apps_count = 4;

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
  
};


camera_recorder camrecbackend;
benchmarks benchmarksbackend;
gpu_performance gpuperfbackend;
//LiveCamera live_camera;

void platform_setup(QQmlApplicationEngine *engine) {
    engine->rootContext()->setContextProperty("camrecbackend", &camrecbackend);
    engine->rootContext()->setContextProperty("benchmarksbackend", &benchmarksbackend);
    engine->rootContext()->setContextProperty("gpuperfbackend", &gpuperfbackend);
    //engine->rootContext()->setContextProperty("live_camera", &live_camera);
    
}

