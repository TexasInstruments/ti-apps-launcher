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

extern app_info include_apps[];
extern power_actions include_powerbuttons[];
void platform_setup(QQmlApplicationEngine *engine);
