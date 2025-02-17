/* Configuration file for AM69 SK*/

#include <iostream>
#include "backend/includes/common.h"
#include "backend/includes/live_camera.h"
#include "backend/includes/camera.h"
#include "backend/includes/run_cmd.h"
#include "backend/includes/settings.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/benchmarks.h"

#include "config_common.h"

using namespace std;
QString platform = "am69-sk";
QString wallpaper = "file:///opt/ti-apps-launcher/assets/am6x_oob_demo_home_image.png";

power_actions include_powerbuttons[] = {
    {
        .name = "Shutdown",
        .command = "shutdown now",
        .icon_source = "file:///opt/ti-apps-launcher/assets/shutdown.png",
    },
    {
        .name = "Reboot",
        .command = "reboot",
        .icon_source = "file:///opt/ti-apps-launcher/assets/reboot.png",
    }
};
int include_powerbuttons_count = ARRAY_SIZE(include_powerbuttons);

app_info include_apps[] = {
    app_industrial_control_sitara,
    app_camera,
    app_benchmarks_jacinto,
    app_gpu_performance,
    app_seva_store,
    app_chromium_browser,
    app_settings,
};
int include_apps_count = ARRAY_SIZE(include_apps);

Settings settings;
LiveCamera live_camera;
Camera camera;
Benchmarks benchmarks;
Gpu_performance gpuperformance;

RunCmd *seva_store = new RunCmd(QStringLiteral("su weston -c \"chromium http://localhost:8007/#/\""));
RunCmd *sdk_datasheet = new RunCmd(QStringLiteral("su weston -c \"chromium https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-am69/latest/exports/docs/devices/J7_Family/linux/Release_Specific_Performance_Guide.html\""));
RunCmd *chromium_browser = new RunCmd(QStringLiteral("su weston -c \"chromium https://webglsamples.org/aquarium/aquarium.html\""));
RunCmd *poweraction = new RunCmd(QStringLiteral(""));

void platform_setup(QQmlApplicationEngine *engine) {
    std::cout << "Running Platform Setup of AM69x!" << endl;
    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("camera", &camera);
    engine->rootContext()->setContextProperty("cameralist", &camera.Camera_list);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("sdk_datasheet", sdk_datasheet);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);
    engine->rootContext()->setContextProperty("chromium_browser", chromium_browser);
    engine->rootContext()->setContextProperty("poweraction", poweraction);
}

