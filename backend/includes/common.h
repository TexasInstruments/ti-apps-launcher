#ifndef BACKEND_INCLUDES_COMMON_H
#define BACKEND_INCLUDES_COMMON_H

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
    QStringList args;
    QString icon_source;
};

struct device_info {
    QString dtMatchString;
    QString platform;
    QString wallpaper;
    QVector<app_info> include_apps;
    QVector<power_actions> include_powerbuttons;
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

#endif // BACKEND_INCLUDES_COMMON_H
