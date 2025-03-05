#include <QObject>
#include <QProcess>
#include <QFile>

class Benchmarks : public QObject {
    Q_OBJECT

private:
    QFile file{"/opt/ti-apps-launcher/glmark2-log.txt"};
    QString stdout1;
    QProcess gpuprocess;
    QProcess systembenchmarks;
    QProcess process1;

public:
    Q_INVOKABLE void playbutton1pressed();
    Q_INVOKABLE void playbutton1pressedagain(); 
    Q_INVOKABLE QString playbutton1fps();
    Q_INVOKABLE QString playbutton1score();
    Q_INVOKABLE void playedcompletely();
    Q_INVOKABLE bool islogavl();
    Q_INVOKABLE void systemplaybutton1pressed();
    Q_INVOKABLE void systemplaybutton2pressed();
    Q_INVOKABLE void systemplaybutton3pressed();
    Q_INVOKABLE void systemplaybutton4pressed();
    Q_INVOKABLE void systemplaybutton5pressed();
};
