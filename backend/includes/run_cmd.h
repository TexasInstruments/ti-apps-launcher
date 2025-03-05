#include <QObject>
#include <QString>
#include <QProcess>

class RunCmd : public QObject {
    Q_OBJECT

private:
    QString _button;
    QString _status_msg;

    QString _command;
    QStringList _args;
    QProcess process;

public:
    Q_PROPERTY(QString button MEMBER _button NOTIFY button_changed);
    Q_PROPERTY(QString status_msg MEMBER _status_msg NOTIFY status_msg_changed);

    RunCmd(QString command, QStringList args);

    Q_INVOKABLE void launch_or_stop();
    Q_INVOKABLE void run(QString command, QStringList args);

signals:
    void button_changed();
    void status_msg_changed();

public Q_SLOTS:
    void onStateChanged(const QProcess::ProcessState &new_state);
};

