/* Configuration file for Generic/Unknown Devices */

#include <iostream>
#include "../backend/includes/common.h"
#include "../backend/includes/seva_store.h"
#include "../backend/includes/settings.h"

using namespace std;

#define PLATFORM "generic"


int include_apps_count = 3;
QString platform = "generic";

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
        .qml_source = "seva_store.qml",
        .name = "Seva Store",
        .icon_source = "seva_store.png"
    }
};

SevaStore *seva_store = new SevaStore("gvim");

Settings settings;


void platform_setup(QQmlApplicationEngine *engine) {
    cout << "Running platform setup for" << PLATFORM << "!" << endl;
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("settings", &settings);
}
