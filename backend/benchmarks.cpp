#include "includes/benchmarks.h"
using namespace std;

QString stdout1,stdout11;
QProcess process1,process11;

void Benchmarks::playbutton1pressed() {
    process1.start("glmark2-es2-wayland -b build:duration=10");
}

void Benchmarks::playbutton1pressedagain() {
    process11.start("killall glmark2-es2-wayland");
    process11.waitForFinished();
}
QString Benchmarks::playbutton1fps() {
    stdout1 = process1.readAllStandardOutput();
    //qDebug()<<stdout1;
    return stdout1.mid(stdout1.indexOf("FPS")+7,6);
}
QString Benchmarks::playbutton1score() {
    return stdout1.mid(stdout1.indexOf("Score")+7,5);
}

QProcess systembenchmarks;

void Benchmarks::systemplaybutton1pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/home/weston/run-dhrystone.sh");
}
void Benchmarks::systemplaybutton2pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/home/weston/run-linpack.sh");
}
void Benchmarks::systemplaybutton3pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/home/weston/run-nbench.sh");
}
void Benchmarks::systemplaybutton4pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/home/weston/run-stream.sh");
}
void Benchmarks::systemplaybutton5pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/home/weston/run-whetstone.sh");
}
