#include "includes/benchmarks.h"

#include <QStringListModel>
#include <QDebug>
#include <QFile>

void Benchmarks::playbutton1pressed() {
    gpuprocess.setStandardOutputFile("/opt/ti-apps-launcher/glmark2-temp-log.txt");
    gpuprocess.start("glmark2-es2-wayland", {"-b", "build:duration=30"});
}

bool Benchmarks::islogavl() {
    file.open(QIODevice::ReadOnly);
    stdout1 = file.readAll();
    file.close();
    QString output = stdout1.mid(stdout1.indexOf("FPS")+5,1);
    if(output.isEmpty())
        return false;

    int res = output.toInt();
    if(res >= 0 && res <= 9)
        return true;
    else
        return false;
}

void Benchmarks::playbutton1pressedagain() {
    gpuprocess.kill();
    gpuprocess.waitForFinished(-1);
    process1.start("rm", {"/opt/ti-apps-launcher/glmark2-temp-log.txt"});
}

void Benchmarks::playedcompletely() {
    process1.start("mv", {"/opt/ti-apps-launcher/glmark2-temp-log.txt", "/opt/ti-apps-launcher/glmark2-log.txt"});
    process1.waitForFinished(-1);
}

QString Benchmarks::playbutton1fps() {
    file.open(QIODevice::ReadOnly);
    stdout1 = file.readAll();
    file.close();
    // Index of actual score comes 5 indices after index of "F". Ex: FPS: <FPS>
    int index = stdout1.indexOf("FPS")+5;
    QString res;
    for(int i = index; stdout1[i] != ' ' && stdout1[i] != '\n'; i++)
    {
        res.append(stdout1[i]);
    }
    return res;
}

QString Benchmarks::playbutton1score() {
    // Index of actual score comes 7 indices after index of "S". Ex: Score: <Score>
    int index = stdout1.indexOf("Score") + 7;
    QString res;
    for(int i = index; stdout1[i] != ' ' && stdout1[i] != '\n'; i++)
    {
        res.append(stdout1[i]);
    }
    return res;
}

void Benchmarks::systemplaybutton1pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal", {"--shell=/opt/ti-apps-launcher/run-dhrystone.sh"});
}
void Benchmarks::systemplaybutton2pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal", {"--shell=/opt/ti-apps-launcher/run-linpack.sh"});
}
void Benchmarks::systemplaybutton3pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal", {"--shell=/opt/ti-apps-launcher/run-nbench.sh"});
}
void Benchmarks::systemplaybutton4pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal", {"--shell=/opt/ti-apps-launcher/run-stream.sh"});
}
void Benchmarks::systemplaybutton5pressed() {
    systembenchmarks.kill();
    systembenchmarks.waitForFinished();
    systembenchmarks.start("weston-terminal", {"--shell=/opt/ti-apps-launcher/run-whetstone.sh"});
}
