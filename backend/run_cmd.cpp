#include "include/run_cmd.h"
#include <iostream>
#include <unordered_map>

using namespace std;

extern unordered_map<string, string> proxy_list;

void RunCmd::onStateChanged(const QProcess::ProcessState &new_state) {
    if( process.state() == QProcess::NotRunning ) {
        cout << "Exited " << _command.toStdString() << endl;
        _button = "Launch";
        _status_msg = "Click 'Launch' to run.";
    } else if ( process.state() == QProcess::Running ) {
        cout << "started " << _command.toStdString() << endl;
        _button = "Stop";
        _status_msg = "Click 'Stop' to kill.";
    } else {
        cout << "starting " << _command.toStdString() << endl;
    }
    Q_EMIT button_changed();
    Q_EMIT status_msg_changed();
}

QString RunCmd::button() {
    return _button;
}

QString RunCmd::status_msg() {
    return _status_msg;
}

RunCmd::RunCmd(QString command) {
    _command = command;
    _status_msg = "Click 'Launch' to run.";
    _button = "Launch";
    env = QProcessEnvironment::systemEnvironment();
    QObject::connect(&process, &QProcess::stateChanged, this, &RunCmd::onStateChanged);
}

void RunCmd::launch_or_stop() {
    QByteArray output_bytes;
    QString output_string;
    if( process.state() == QProcess::NotRunning ) {
        env.insert("XDG_RUNTIME_DIR", "/run/user/1000");
        env.insert("WAYLAND_DISPLAY", "wayland-1");
        env.insert("QT_QPA_PLATFORM", "wayland");
        if(proxy_list["https_proxy"].size()) {
            env.insert("http_proxy",proxy_list["https_proxy"].c_str());
            env.insert("https_proxy",proxy_list["https_proxy"].c_str());
            env.insert("ftp_proxy",proxy_list["https_proxy"].c_str());
            env.insert("HTTP_PROXY",proxy_list["https_proxy"].c_str());
            env.insert("HTTPS_PROXY",proxy_list["https_proxy"].c_str());
            env.insert("FTP_PROXY",proxy_list["https_proxy"].c_str());
        }
        if(proxy_list["no_proxy"].size()) {
            env.insert("no_proxy",proxy_list["no_proxy"].c_str());
            env.insert("NO_PROXY",proxy_list["no_proxy"].c_str());
        }
        process.setProcessEnvironment(env);
        process.start(_command);
    } else if ( process.state() == QProcess::Running ) {
        process.kill();
    }
}

void RunCmd::run(QString command) {
    QByteArray output_bytes;
    QString output_string;
    _command = command;

    if( process.state() == QProcess::NotRunning ) {
        env.insert("XDG_RUNTIME_DIR", "/run/user/1000");
        env.insert("WAYLAND_DISPLAY", "wayland-1");
        env.insert("QT_QPA_PLATFORM", "wayland");
        if(proxy_list["https_proxy"].size()) {
            env.insert("http_proxy",proxy_list["https_proxy"].c_str());
            env.insert("https_proxy",proxy_list["https_proxy"].c_str());
            env.insert("ftp_proxy",proxy_list["https_proxy"].c_str());
            env.insert("HTTP_PROXY",proxy_list["https_proxy"].c_str());
            env.insert("HTTPS_PROXY",proxy_list["https_proxy"].c_str());
            env.insert("FTP_PROXY",proxy_list["https_proxy"].c_str());
        }
        if(proxy_list["no_proxy"].size()) {
            env.insert("no_proxy",proxy_list["no_proxy"].c_str());
            env.insert("NO_PROXY",proxy_list["no_proxy"].c_str());
        }
        process.setProcessEnvironment(env);
        process.start(_command);
    } else if ( process.state() == QProcess::Running ) {
        process.kill();
    }
}
