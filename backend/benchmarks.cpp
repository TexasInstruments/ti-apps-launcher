#include "includes/benchmarks.h"
using namespace std;

QString stdout1,stdout11;
QProcess process1,process11;

void benchmarks::playbutton1pressed() {
    process1.start("glmark2-es2-wayland");
}

void benchmarks::playbutton1pressedagain() {
    process11.start("killall glmark2-es2-wayland");
    process11.waitForFinished();
}
QString benchmarks::playbutton1fps() {
    stdout1 = process1.readAllStandardOutput();
    //qDebug()<<stdout1;
    return stdout1.mid(stdout1.indexOf("FPS")+7,6);
}
QString benchmarks::playbutton1score() {
    return stdout1.mid(stdout1.indexOf("Score")+7,5);
}