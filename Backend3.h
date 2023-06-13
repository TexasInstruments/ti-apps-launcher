#include <QObject>
#include <iostream>

#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include<QMediaPlayer>
using namespace std;


class Backend3 : public QObject {
    Q_OBJECT

private:

public:

    QString stdout1,stdout11;
    QProcess process1,process11;
    Q_INVOKABLE void playbutton1pressed() {
        process1.start("glmark2-es2-wayland");
    }
    
    Q_INVOKABLE void playbutton1pressedagain() {
        process11.start("killall glmark2-es2-wayland");
        process11.waitForFinished();
        stdout11= process11.readAllStandardOutput();
    }
    Q_INVOKABLE QString playbutton1fps() {
        stdout1 = process1.readAllStandardOutput();
        qDebug()<<stdout1;
        return stdout1.mid(stdout1.indexOf("FPS")+7,6);
    }
    Q_INVOKABLE QString playbutton1score() {
        //stdout11= process11.readAllStandardOutput();
        //qDebug()<<stdout11;
        return stdout1.mid(stdout1.indexOf("Score")+7,5);
    }
    

};
