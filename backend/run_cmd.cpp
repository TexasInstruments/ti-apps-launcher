#include "includes/run_cmd.h"
#include <iostream>

using namespace std;

void RunCmd::onStateChanged(const QProcess::ProcessState &new_state) {
    if( process.state() == QProcess::NotRunning ) {
        cout << "Killed " << _command.toStdString() << endl;
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
        process.setProcessEnvironment(env);
        process.start(_command);
        output_bytes = process.readAllStandardError();
        output_string = QString(output_bytes);
        cout << "output: " << output_string.toStdString() << endl;
    } else if ( process.state() == QProcess::Running ) {
        process.kill();
    }
}
