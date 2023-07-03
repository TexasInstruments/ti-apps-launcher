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


class Gpu_performance : public QObject {
    Q_OBJECT

private:

public:

    Q_INVOKABLE void gpuload0();
    Q_INVOKABLE void gpuload1();
    Q_INVOKABLE void gpuload2();
    Q_INVOKABLE void gpuload3();
    Q_INVOKABLE void gpuload4();

    Q_INVOKABLE QString getfps();
    Q_INVOKABLE QString getscore();

};
