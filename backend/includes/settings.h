#include <QString>
#include <QObject>

class Settings : public QObject {
    Q_OBJECT

public:
    QString https_proxy;
    QString no_proxy;
    Q_INVOKABLE void set_proxy(QString https_proxy, QString no_proxy);

private:
    void set_environment_variables();
    void apply_docker_proxy();
};
