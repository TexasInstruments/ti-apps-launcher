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

class Device_info : public QObject {
    Q_OBJECT

public:
    Q_INVOKABLE QString getplatform();
};