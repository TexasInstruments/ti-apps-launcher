#include <QString>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QProcess>

class SevaStore : public QObject {
    Q_OBJECT

private:
    QString _button;
    QString _status_msg;

    QString _command;
    QProcess seva_process;
    QProcessEnvironment env;

public:
    Q_PROPERTY(QString button READ button NOTIFY button_changed);
    Q_PROPERTY(QString status_msg READ status_msg NOTIFY status_msg_changed);

    SevaStore(QString command);

    Q_INVOKABLE QString button();

    QString status_msg();

    Q_INVOKABLE void launch_or_stop();

signals:
    void button_changed();
    void status_msg_changed();

public Q_SLOTS:
    void onStateChanged(const QProcess::ProcessState &new_state);
};

