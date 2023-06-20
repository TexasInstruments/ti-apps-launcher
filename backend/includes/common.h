/* Configurations for Generic/Unknown Platforms */

#include <QQmlApplicationEngine>
#include <QString>

struct app_info {
    QString qml_source;
    QString name;
    QString icon_source;
};

extern app_info include_apps[];

void platform_setup(QQmlApplicationEngine *engine);
