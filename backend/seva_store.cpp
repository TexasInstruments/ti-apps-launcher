#include "includes/seva_store.h"
#include <iostream>

using namespace std;

// QString seva_store_command = "sudo WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000/ seva-launcher-aarch64";
// QString seva_store_command = "gvim";
// QString seva_store_command = "seva-launcher-aarch64";

void SevaStore::onStateChanged(const QProcess::ProcessState &new_state) {
    if( seva_process.state() == QProcess::NotRunning ) {
        cout << "Not running signal" << endl;
        _button = "Launch";
        _status_msg = "Click 'Launch' to start Seva Store.\n Note: Seva Store will be run in a separate window.";
    } else if ( seva_process.state() == QProcess::Running ) {
        cout << "running signal" << endl;
        _button = "Stop";
        _status_msg = "Click 'Stop' to stop Seva Store.\n Note: Seva Store will be run in a separate window.";
    } else {
        cout << "some other signal" << endl;
    }
    Q_EMIT button_changed();
    Q_EMIT status_msg_changed();
}

QString SevaStore::button() {
    return _button;
}

QString SevaStore::status_msg() {
    return _status_msg;
}

SevaStore::SevaStore(QString command) {
    _command = command;
    cout << "_command = " << _command.toStdString() << endl;
    _status_msg = "Click 'Launch' to start Seva Store.\n Note: Seva Store will be run in a separate window.";
    _button = "Launch";
    env = QProcessEnvironment::systemEnvironment();
    QObject::connect(&seva_process, &QProcess::stateChanged, this, &SevaStore::onStateChanged);
}


void SevaStore::launch_or_stop() {
    QByteArray output_bytes;
    QString output_string;
    if( seva_process.state() == QProcess::NotRunning ) {
	env.insert("WAYLAND_DISPLAY", "wayland-1");
	seva_process.setProcessEnvironment(env);
        seva_process.start(_command);
	output_bytes = seva_process.readAllStandardError();
	output_string = QString(output_bytes);
	cout << "output: " << output_string.toStdString() << endl;
    } else if ( seva_process.state() == QProcess::Running ) {
        seva_process.kill();
    }
}
