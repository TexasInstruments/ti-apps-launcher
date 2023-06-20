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


class camera_recorder : public QObject {
    Q_OBJECT

private:

public:



    Q_INVOKABLE void playcam();
    Q_INVOKABLE void startrec(); 
    Q_INVOKABLE void stoprec(); 
    Q_INVOKABLE void stopcam(); 
    Q_INVOKABLE void startvideo();
    Q_INVOKABLE void stopvideo();
    Q_INVOKABLE int isvideocomplete();
};
