/* Configuration file for Generic/Unknown Devices */

#include "../backend/includes/common.h"
#define PLATFORM "am69-sk"


int include_apps_count = 4;
QString platform = "am69-sk"

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

