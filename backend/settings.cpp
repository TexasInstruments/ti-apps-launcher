#include "includes/settings.h"

#include <filesystem>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>

#include <QDebug>

void Settings::set_environment_variables() {
    qputenv("https_proxy", https_proxy.toUtf8());
    qputenv("http_proxy", https_proxy.toUtf8());
    qputenv("ftp_proxy", https_proxy.toUtf8());
    qputenv("no_proxy", no_proxy.toUtf8());
    qputenv("HTTPS_PROXY", https_proxy.toUtf8());
    qputenv("HTTP_PROXY", https_proxy.toUtf8());
    qputenv("FTP_PROXY", https_proxy.toUtf8());
}

/**
 * @brief Writes a systemd drop‑in file containing the current proxy env vars.
 * 
 * @param service_dropin_dir  Path to the service's ".service.d" directory,
 *                          e.g. "/etc/systemd/system/docker.service.d".
 */
void Settings::install_systemd_proxy_dropin(const QString &service_name) {

    /* Check if input is empty */
    if(service_name.isEmpty()) {
        return;
    }
    QString service_dropin_path = "/etc/systemd/system/" + service_name + ".service.d";
    /* Create /etc/systemd/system/myservice.service.d directory structure */
    QString mkdir_cmd = "mkdir -p /etc/systemd/system/" + service_dropin_path;
    if(system(qPrintable(mkdir_cmd)) == -1){
        qCritical() << "Failed to create directory structure for proxies at " << service_dropin_path;
        return;
    }

    /* Write the proxy setting */
    QString apply_systemd_proxy = "echo [Service] | tee " + service_dropin_path + "/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    apply_systemd_proxy = "echo Environment=HTTPS_PROXY=" + https_proxy + " | tee -a " + service_dropin_path + "/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    apply_systemd_proxy = "echo Environment=HTTP_PROXY=" + https_proxy + " | tee -a " + service_dropin_path + "/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    apply_systemd_proxy = "echo Environment=NO_PROXY=" + no_proxy + " | tee -a " + service_dropin_path + "/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    /* Flush changes, Re-load Daemon */
    system("systemctl daemon-reload");

    /* Restart service */
    QString systemd_restart_cmd = "systemctl restart " + service_name;
    system(qPrintable(systemd_restart_cmd));
}

void Settings::set_proxy(QString https_proxy, QString no_proxy) {
    qInfo() << "Setting https_proxy to " << https_proxy;
    qInfo() << "Setting no_proxy to " << no_proxy;

    this->https_proxy = https_proxy;
    this->no_proxy = no_proxy;

    install_systemd_proxy_dropin("docker");
    install_systemd_proxy_dropin("seva-launcher");
    set_environment_variables();

    qInfo() << "Applied Proxy Settings!";
}
