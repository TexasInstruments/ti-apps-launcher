#include "includes/wifi.h"

#include <filesystem>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <vector>
#include <set>
#include <unistd.h>

#include <QSet>
#include <QProcess>
#include <QTimer>

using namespace std;

Wifi::Wifi() {
    m_wifiOn = false;
    m_wifiConnected = false;
    m_previousWifiOn = false;
    checkWifiState();
}

// Method to return wifi status
bool Wifi::wifiOn() {
    return m_wifiOn;
}

// Method to return previous wifi status
bool Wifi::previousWifiOn() {
    return m_previousWifiOn;
}

// Method to return wifi connection
bool Wifi::wifiConnected() {
    return m_wifiConnected;
}

// Method to return ssid
QString Wifi::ssid() {
    return m_ssid;
}

// Method to toggle wifi status
void Wifi::toggle() {
    if(m_wifiOn)
        setWifiOff();
    else
        setWifiOn();
    // wait for 2 sec to before checking wifi status
    sleep(2);
    bool currentState = checkWifiOnState();
    m_previousWifiOn = m_wifiOn;
    if(currentState!=m_wifiOn) {
        m_wifiOn = currentState;
    }
    emit wifiOnChanged();
    emit previousWifiOnChanged();
}

// Method to switch on wifi
void Wifi::setWifiOn() {
    string command = "/usr/share/cc33xx/sta_start.sh";
    system(command.c_str());
}

// Method to switch off wifi
void Wifi::setWifiOff() {
    QProcess process;
    process.start("/usr/share/cc33xx/sta_stop.sh", QStringList({}));
    process.waitForFinished();
    process.start("ip", {"addr", "flush", "dev", "wlan0"});
    process.waitForFinished();
    m_wifiConnected = false;
    m_ssid.clear();
    emit ssidChanged();
    emit wifiConnectedChanged();
}

// Method to check wifi status On or Off
bool Wifi::checkWifiOnState() {
    QProcess process;
    process.start("wpa_cli", {"status"});
    process.waitForFinished();
    QString output = process.readAllStandardOutput();
    QString err = process.readAllStandardError();
    bool currentState = output.toStdString().length() ? true : false;
    return currentState;
}

// Method to check wifi is connected or not
QString Wifi::checkWifiConnectedState() {
    QProcess process;
    process.start("sh", QStringList() << "-c" << "wpa_cli status | grep '^ssid=' | cut -d'=' -f2");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();
    QString err = process.readAllStandardError();
    return output;
}

// Method to check Wi-Fi State (on/off, connected)
void Wifi::checkWifiState() {
    bool currentState = checkWifiOnState();
    if (m_wifiOn != currentState) {
        m_wifiOn = currentState;
        emit wifiOnChanged();
    }
    if (m_wifiOn == true ){
        QString output = checkWifiConnectedState();
        bool currentState = output.toStdString().length() ? true : false ;
        if(currentState) {
            m_ssid = output;
            emit ssidChanged();
        }
        if (m_wifiConnected != currentState) {
            m_wifiConnected = currentState;
            emit wifiConnectedChanged();
        }
    }
}

// Method to fetch SSID names using wpa_cli
void Wifi::fetchSSIDNames() {
    QProcess process;
    process.start("wpa_cli", {"scan"});
    process.waitForFinished();
    process.start("sh", QStringList() << "-c" << "wpa_cli scan_results | awk '{if (NR>2) print $5}'");
    process.waitForFinished();
    QString output = process.readAllStandardOutput();
    QStringList lines = output.split('\n', Qt::SkipEmptyParts);
    // Clear the previous list
    ssidVector.clear();
    QSet<QString> uniqueSSIDs;
    for (const QString &ssid : lines) {
        uniqueSSIDs.insert(ssid);
    }
    // Fill the ssidVector with unique SSIDs
    for (auto &ssid : uniqueSSIDs) {
        ssidVector.push_back(ssid.toStdString());
    }
    emit ssidListChanged();
}

// Method to expose the SSID vector as a QStringList to QML
QStringList Wifi::getSSIDList() {
    QStringList list;
    for (const auto &ssid : ssidVector)
        list.append(QString::fromStdString(ssid));
    return list;
}

// Method to connect to a SSID
void Wifi::connect(QString ssid_name, QString security_type, QString pmf, QString identity,
    QString client_cert_file, QString private_key_cert_file, QString private_key_pass, QString password) {
    if ( ssid_name.toStdString().length() == 0 || password.toStdString().length() < 8 ) {
        return;
    }
    // Connect to network
    string command = string("/usr/share/cc33xx/sta_connect.sh")
        + " -s " + security_type.toStdString()
        + " -n " + ssid_name.toStdString()
        + " -f " + pmf.toStdString();
    if (security_type.compare("SAE") == 0 && security_type.compare("WPA-EAP-SHA256") == 0) {
        command += " -p " + password.toStdString()
        + " -I " + identity.toStdString()
        + " -c " + client_cert_file.toStdString()
        + " -K " + private_key_cert_file.toStdString()
        + " -P " + private_key_pass.toStdString();
    }
    else if (security_type.compare("NONE") != 0) {
        command += " -p " + password.toStdString();
    }
    system(command.c_str());
    // Wait as wpa_cli runs in background
    sleep(6);
    QString state = checkWifiConnectedState();
    if ( state.toStdString().length() == 0 ) {}
    else {
        QProcess process;
        process.start("udhcpc", {"-i wlan0"});
        process.waitForFinished();
        m_ssid = ssid_name;
        emit ssidChanged();
        m_wifiConnected = true;
        emit wifiConnectedChanged();
    }
}

// Method to Disconnect a SSID
void Wifi::disconnect() {
    // Disconnect SSID
    QProcess process;
    process.start("wpa_cli", {"disconnect"});
    process.waitForFinished();
    // Remove ip
    process.start("ip", {"addr", "flush", "dev", "wlan0"});
    process.waitForFinished();
    m_wifiConnected = false;
    m_ssid.clear();
    emit ssidChanged();
    emit wifiConnectedChanged();
}
