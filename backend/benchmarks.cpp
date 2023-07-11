#include "includes/benchmarks.h"
using namespace std;

bool isfirsttime=1;
QString stdout1;
QProcess process1,gpuprocess;
QFile file("/home/weston/log.txt");
void Benchmarks::playbutton1pressed() {
    gpuprocess.setStandardOutputFile("/home/weston/temp.txt");
    gpuprocess.start("glmark2-es2-wayland -b build:duration=10");
}

bool Benchmarks::islogavl() {
    file.open(QIODevice::ReadOnly);
    stdout1 = file.readAll();
    file.close();
    QString output = stdout1.mid(stdout1.indexOf("FPS")+5,1);
    if(output.isEmpty())
    return false;
    int res = output.toInt();
    if(res>=0 && res <=9)
    return true;
    else
    return false;
}
void Benchmarks::playbutton1pressedagain() {
    gpuprocess.kill();
    gpuprocess.waitForFinished(-1);
    process1.start("rm /home/weston/temp.txt");
}
void Benchmarks::playedcompletely() {
    process1.start("mv /home/weston/temp.txt /home/weston/log.txt");
    process1.waitForFinished(-1);
    //process1.start("rm /home/weston/temp.txt");
    //process1.waitForFinished(-1);
}
QString Benchmarks::playbutton1fps() {
    file.open(QIODevice::ReadOnly);
    stdout1 = file.readAll();
    file.close();
    //qDebug()<<stdout1;
    return stdout1.mid(stdout1.indexOf("FPS")+5,4);
}
QString Benchmarks::playbutton1score() {
    return stdout1.mid(stdout1.indexOf("Score")+7,4);
}

QProcess systembenchmarks;

void Benchmarks::systemplaybutton1pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/opt/ti-apps-launcher/run-dhrystone.sh");
}
void Benchmarks::systemplaybutton2pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/opt/ti-apps-launcher/run-linpack.sh");
}
void Benchmarks::systemplaybutton3pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/opt/ti-apps-launcher/run-nbench.sh");
}
void Benchmarks::systemplaybutton4pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/opt/ti-apps-launcher/run-stream.sh");
}
void Benchmarks::systemplaybutton5pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal --shell=/opt/ti-apps-launcher/run-whetstone.sh");
}
