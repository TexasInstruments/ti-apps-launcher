/* Configuration file for AM62x and AM62x-LP */

#include "../backend/includes/common.h"

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
