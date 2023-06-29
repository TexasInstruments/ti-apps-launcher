#include "includes/gpu_performance.h"
using namespace std;

QProcess load;
void gpu_performance::gpuload0(){
    load.kill();
}

void gpu_performance::gpuload1(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland -b buffer:duration=100");
}

void gpu_performance::gpuload2(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland -b ideas:duration=100");
}

void gpu_performance::gpuload3(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland -b texture:duration=100");
}

void gpu_performance::gpuload4(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland -b terrain:duration=100");
}

QString loadout;

QString gpu_performance::getfps(){
    loadout = load.readAllStandardOutput();
    /* Index of actual score comes 5 indices after index of "F". Ex: FPS: <FPS> */
    return loadout.mid(loadout.indexOf("FPS")+5,4);
}

QString gpu_performance::getscore(){
    /* Index of actual score comes 7 indices after index of "S". Ex: Score: <Score> */
    return loadout.mid(loadout.indexOf("Score")+7,4);
}
