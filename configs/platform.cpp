/* Configuration file for Generic/Unknown Devices */

#include <iostream>

#include <QFile>

#include "backend/includes/common.h"
#include "backend/includes/arm_analytics.h"
#include "backend/includes/live_camera.h"
#include "backend/includes/camera.h"
#include "backend/includes/run_cmd.h"
#include "backend/includes/settings.h"
#include "backend/includes/gpu_performance.h"
#include "backend/includes/benchmarks.h"
#include "backend/includes/wifi.h"

#include "config_common.h"

#include "am62pxx-evm.h"
#include "am62xx-evm.h"
#include "am62xx-lp-evm.h"
#include "am62xxsip-evm.h"
#include "am67-sk.h"
#include "am68-sk.h"
#include "am69-sk.h"
#include "beagleplay.h"
#include "generic.h"

using namespace std;

Settings settings;
LiveCamera live_camera;
Camera camera;
ArmAnalytics arm_analytics;
Benchmarks benchmarks;
Gpu_performance gpuperformance;
Wifi wifi;

RunCmd *seva_store = new RunCmd("/usr/bin/su", QStringList({"weston", "-c", "/usr/bin/chromium --no-first-run http://localhost:8007/#/"}));
RunCmd *demo_3d = new RunCmd(QStringLiteral("/usr/bin/SGX/demos/Wayland/OpenGLESSkinning"), QStringList({}));
RunCmd *poweraction = new RunCmd(QStringLiteral(""), QStringList({}));
RunCmd *chromium_browser = new RunCmd("/usr/bin/su", QStringList({"weston", "-c", "chromium --no-first-run https://webglsamples.org/aquarium/aquarium.html"}));

QMap<enum devices, struct device_info> deviceMap = {
    { AM62PXX_EVM, device_info_am62p },
    { AM62XX_EVM, device_info_am62 },
    { AM62XX_LP_EVM, device_info_am62_lp },
    { AM62XXSIP_EVM, device_info_am62sip },
    { AM67_SK, device_info_am67 },
    { AM68_SK, device_info_am68 },
    { AM69_SK, device_info_am69 },
    { BEAGLEPLAY, device_info_beagleplay },
    { GENERIC, device_info_generic },
};

enum devices detect_device()
{
    QFile file("/proc/device-tree/model");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return GENERIC;

    QTextStream in(&file);
    QString content = in.readAll();
    file.close();

    for (auto it = deviceMap.keyValueBegin(); it != deviceMap.keyValueEnd(); ++it)
        if (content.contains(it->second.dtMatchString, Qt::CaseInsensitive))
            return it->first;

    return GENERIC;
}

enum devices detected_device;

void platform_setup(QQmlApplicationEngine *engine)
{
    detected_device = detect_device();

    cout << "Running " << deviceMap[detected_device].platform.toStdString() << " Platform Setup!" << endl;

    engine->rootContext()->setContextProperty("live_camera", &live_camera);
    engine->rootContext()->setContextProperty("camera", &camera);
    engine->rootContext()->setContextProperty("cameralist", &camera.Camera_list);
    engine->rootContext()->setContextProperty("arm_analytics", &arm_analytics);
    engine->rootContext()->setContextProperty("chromium_browser", chromium_browser);
    engine->rootContext()->setContextProperty("seva_store", seva_store);
    engine->rootContext()->setContextProperty("demo_3d", demo_3d);
    engine->rootContext()->setContextProperty("settings", &settings);
    engine->rootContext()->setContextProperty("wifi", &wifi);
    engine->rootContext()->setContextProperty("benchmarks", &benchmarks);
    engine->rootContext()->setContextProperty("gpuperformance", &gpuperformance);
    engine->rootContext()->setContextProperty("poweraction", poweraction);
}
