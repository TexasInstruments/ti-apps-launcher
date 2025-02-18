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

void Settings::apply_docker_proxy() {
    // Create /etc/systemd/system/docker.service.d directory structure
    if(system("mkdir -p /etc/systemd/system/docker.service.d") == -1){
        qCritical() << "Failed to create directory structure for docker proxies";
        return;
    }

    // Write the docker proxy setting
    QString apply_systemd_proxy = "echo [Service] | tee /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    apply_systemd_proxy = "echo Environment=HTTPS_PROXY=" + https_proxy + " | tee -a /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    apply_systemd_proxy = "echo Environment=HTTP_PROXY=" + https_proxy + " | tee -a /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    apply_systemd_proxy = "echo Environment=NO_PROXY=" + no_proxy + " | tee -a /etc/systemd/system/docker.service.d/http-proxy.conf";
    system(qPrintable(apply_systemd_proxy));

    // Flush changes, Re-load Daemon and Re-Start Docker
    system("systemctl daemon-reload");
    system("systemctl restart docker");
}

void Settings::set_proxy(QString https_proxy, QString no_proxy) {
    qInfo() << "Setting https_proxy to " << https_proxy;
    qInfo() << "Setting no_proxy to " << no_proxy;

    this->https_proxy = https_proxy;
    this->no_proxy = no_proxy;

    apply_docker_proxy();
    set_environment_variables();

    qInfo() << "Applied Proxy Settings!";
}
