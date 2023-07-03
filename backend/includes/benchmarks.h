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
    

};
