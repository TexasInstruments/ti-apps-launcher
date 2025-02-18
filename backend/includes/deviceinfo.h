#include <QObject>
#include <QString>

class Device_info : public QObject {
    Q_OBJECT

private:
    QString ip_addr_p;

public:
    Q_PROPERTY(QString ip_addr READ ip_addr WRITE set_ip_addr NOTIFY ip_addr_changed)

    Q_INVOKABLE QString getplatform();

    Q_INVOKABLE QString getWallpaper();

    Q_INVOKABLE QString ip_addr() {
        return ip_addr_p;
    }

    void set_ip_addr(QString ip_addr_n) {
        ip_addr_p = ip_addr_n;
        emit ip_addr_changed();
    }

signals:
    void ip_addr_changed();
};
