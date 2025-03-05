#include "includes/run_cmd.h"
#include "includes/settings.h"

#include <QDebug>

extern Settings settings;

void RunCmd::onStateChanged(const QProcess::ProcessState &new_state) {
    if( process.state() == QProcess::NotRunning ) {
        qInfo() << "Exited " << _command << _args;
        _button = "Launch";
        _status_msg = "Click 'Launch' to run.";
    } else if ( process.state() == QProcess::Running ) {
        qInfo() << "Started " << _command << _args;
        _button = "Stop";
        _status_msg = "Click 'Stop' to kill.";
    } else {
        qInfo() << "Starting " << _command;
    }
    Q_EMIT button_changed();
    Q_EMIT status_msg_changed();
}

RunCmd::RunCmd(QString command, QStringList args) {
    _command = command;
    _args = args;
    _status_msg = "Click 'Launch' to run.";
    _button = "Launch";
    QObject::connect(&process, &QProcess::stateChanged, this, &RunCmd::onStateChanged);
}

void RunCmd::launch_or_stop() {
    QByteArray output_bytes;
    QString output_string;
    if( process.state() == QProcess::NotRunning ) {
        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
        env.insert("XDG_RUNTIME_DIR", "/run/user/1000");
        env.insert("WAYLAND_DISPLAY", "wayland-1");
        env.insert("QT_QPA_PLATFORM", "wayland");
        if( settings.https_proxy != "" ) {
            env.insert("http_proxy", settings.https_proxy);
            env.insert("https_proxy", settings.https_proxy);
            env.insert("ftp_proxy", settings.https_proxy);
            env.insert("HTTP_PROXY", settings.https_proxy);
            env.insert("HTTPS_PROXY", settings.https_proxy);
            env.insert("FTP_PROXY", settings.https_proxy);
        }
        if( settings.no_proxy != "" ) {
            env.insert("no_proxy", settings.no_proxy);
            env.insert("NO_PROXY", settings.no_proxy);
        }
        process.setProcessEnvironment(env);
        process.start(_command, _args);
    } else if ( process.state() == QProcess::Running ) {
        process.kill();
    }
}

void RunCmd::run(QString command, QStringList args) {
    QByteArray output_bytes;
    QString output_string;
    _command = command;
    _args = args;

    if( process.state() == QProcess::NotRunning ) {
        QProcessEnvironment env = QProcessEnvironment::systemEnvironment();
        env.insert("XDG_RUNTIME_DIR", "/run/user/1000");
        env.insert("WAYLAND_DISPLAY", "wayland-1");
        env.insert("QT_QPA_PLATFORM", "wayland");
        if( settings.https_proxy != "" ) {
            env.insert("http_proxy", settings.https_proxy);
            env.insert("https_proxy", settings.https_proxy);
            env.insert("ftp_proxy", settings.https_proxy);
            env.insert("HTTP_PROXY", settings.https_proxy);
            env.insert("HTTPS_PROXY", settings.https_proxy);
            env.insert("FTP_PROXY", settings.https_proxy);
        }
        if( settings.no_proxy != "" ) {
            env.insert("no_proxy", settings.no_proxy);
            env.insert("NO_PROXY", settings.no_proxy);
        }
        process.setProcessEnvironment(env);
        process.start(_command, _args);
    } else if ( process.state() == QProcess::Running ) {
        process.kill();
    }
}
