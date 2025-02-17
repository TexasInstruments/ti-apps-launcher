#include <QString>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

struct app_info {
    QString qml_source;
    QString name;
    QString icon_source;
};

struct power_actions {
    QString name;
    QString command;
    QString icon_source;
};

struct device_info {
    QString dtMatchString;
    QString platform;
    QString wallpaper;
    app_info *include_apps;
    int include_apps_count;
    power_actions *include_powerbuttons;
    int include_powerbuttons_count;
};

enum devices {
    AM62PXX_EVM,
    AM62XX_EVM,
    AM62XX_LP_EVM,
    AM62XXSIP_EVM,
    AM67_SK,
    AM68_SK,
    AM69_SK,
    BEAGLEPLAY,
    GENERIC,
};

extern QMap<enum devices, struct device_info> deviceMap;

extern enum devices detected_device;

void platform_setup(QQmlApplicationEngine *engine);
