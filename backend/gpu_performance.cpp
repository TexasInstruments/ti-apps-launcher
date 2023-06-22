#include <QObject>
#include <iostream>

#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include<QMediaPlayer>

#include "includes/gpu_performance.h"
using namespace std;

QProcess load0,load1,load2,load3,load4;
void gpu_performance::gpuload0(){
    load0.kill();
    load1.kill();
    load2.kill();
    load3.kill();
    load4.kill();
    //load0.start("killall glmark2-es2-wayland");
}
void gpu_performance::gpuload1(){
    gpuload0();
    //load1.start("killall glmark2-es2-wayland");
    load1.waitForFinished();
    load1.start("glmark2-es2-wayland -b buffer:duration=100");
}
void gpu_performance::gpuload2(){
    gpuload0();
    //load2.start("killall glmark2-es2-wayland");
    load2.waitForFinished();
    load2.start("glmark2-es2-wayland -b ideas:duration=100");
}
void gpu_performance::gpuload3(){
    //load3.kill();
    gpuload0();
    //load3.start("killall glmark2-es2-wayland");
    load3.waitForFinished();
    load3.start("glmark2-es2-wayland -b texture:duration=100");
}
void gpu_performance::gpuload4(){
    gpuload0();
   
    load4.waitForFinished();
    load4.start("glmark2-es2-wayland -b terrain:duration=100");
}
