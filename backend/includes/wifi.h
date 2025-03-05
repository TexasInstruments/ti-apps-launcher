#include <vector>
#include <string>
#include <QString>
#include <QObject>

class Wifi : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList ssidList READ getSSIDList NOTIFY ssidListChanged)
    Q_PROPERTY(bool wifiOn READ wifiOn NOTIFY wifiOnChanged)
    Q_PROPERTY(bool wifiConnected READ wifiConnected NOTIFY wifiConnectedChanged)
    Q_PROPERTY(QString ssid READ ssid NOTIFY ssidChanged)
    Q_PROPERTY(bool previousWifiOn READ previousWifiOn NOTIFY previousWifiOnChanged)

public:
    Q_INVOKABLE explicit Wifi();
    Q_INVOKABLE void connect(QString ssid_name, QString security_type, QString pmf, QString identity,
        QString client_cert_file, QString private_key_cert_file, QString private_key_pass, QString password);
    Q_INVOKABLE void fetchSSIDNames();
    Q_INVOKABLE QStringList getSSIDList();
    Q_INVOKABLE bool wifiOn();
    Q_INVOKABLE bool previousWifiOn();
    Q_INVOKABLE bool wifiConnected();
    Q_INVOKABLE void toggle();
    Q_INVOKABLE void setWifiOn();
    Q_INVOKABLE void setWifiOff();
    Q_INVOKABLE void checkWifiState();
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE QString ssid();
    Q_INVOKABLE bool checkWifiOnState();
    Q_INVOKABLE QString checkWifiConnectedState();

signals:
    void wifiOnChanged(); // Signal to notify QML of wifi status changes
    void ssidListChanged();  // Signal to notify QML of ssid List changes
    void wifiConnectedChanged(); // Signal to notify QML of wifi connection changes
    void ssidChanged(); // Signal to notify QML of ssid changes
    void previousWifiOnChanged(); // Signal to notify QML of previouswifistatus

private:
    std::vector<std::string> ssidVector;  // Vector to store SSID names
    QString m_ssid; // Store SSID
    bool m_wifiOn; // Store wifi status
    bool m_wifiConnected; // Store wifi connect status
    bool m_previousWifiOn; // Store previous wifi status
};
