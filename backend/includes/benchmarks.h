#include <QObject>
#include <iostream>

#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include<QMediaPlayer>
#include <QFile>
using namespace std;


class Benchmarks : public QObject {
    Q_OBJECT

private:

public:

    QString stdout1,stdout11;
    QProcess process1,process11;
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
