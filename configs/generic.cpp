/* Configuration file for Generic/Unknown Devices */

#include <iostream>
#include "../backend/includes/common.h"

#define PLATFORM "generic"

int include_apps_count = 2;

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
};

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "No platform specific setup required for generic!" << endl;
}
