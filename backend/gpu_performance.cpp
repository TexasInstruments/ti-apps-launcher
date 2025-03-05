#include "includes/gpu_performance.h"

void Gpu_performance::gpuload0(){
    load.kill();
}

void Gpu_performance::gpuload1(){
    gpuload0();
    load.waitForFinished();
    /* The duration of the benchmark has to be tied to the time interval of the
       Timer in the gpu_performance.qml. This is because we are reading the standard
       output in the timer task */
    load.start("glmark2-es2-wayland", {"-b", "buffer:duration=30"});
}

void Gpu_performance::gpuload2(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland", {"-b", "ideas:duration=30"});
}

void Gpu_performance::gpuload3(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland", {"-b", "texture:duration=30"});
}

void Gpu_performance::gpuload4(){
    gpuload0();
    load.waitForFinished();
    load.start("glmark2-es2-wayland", {"-b", "terrain:duration=30"});
}

QString Gpu_performance::getfps(){
    loadout = load.readAllStandardOutput();
    // Index of actual score comes 5 indices after index of "F". Ex: FPS: <FPS>
    int index = loadout.indexOf("FPS")+5;
    QString res;
    for(int i = index; loadout[i] != ' ' && loadout[i] != '\n'; i++)
    {
        res.append(loadout[i]);
    }
    return res;
}

QString Gpu_performance::getscore(){
    // Index of actual score comes 7 indices after index of "S". Ex: Score: <Score>
    int index = loadout.indexOf("Score")+7;
    QString res;
    for(int i= index ; loadout[i] != ' ' && loadout[i] != '\n'; i++)
    {
        res.append(loadout[i]);
    }
    return res;
}
