#include <QObject>
#include <iostream>

#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include<QMediaPlayer>
#include "includes/camera_recorder.h"
using namespace std;

QProcess camstart;
    void camera_recorder::playcam() {   
        camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! waylandsink");
        //camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! video/x-raw, width=640, height=480, format=UYVY ! waylandsink");
    }
    QProcess startrecording1,startrecording;
    void camera_recorder::startrec() {
        //startrecording.start("killall gst-launch-1.0");
        camstart.kill();
        camstart.waitForFinished(-1);
        //startrecording.waitForFinished(-1);
        startrecording.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw,format=NV12 ! tiovxmemalloc ! tee name=t t. ! queue ! waylandsink sync=False t. ! queue ! v4l2h264enc bitrate=10000000 ! h264parse ! matroskamux ! filesink sync=False location=/home/root/output_video111.mkv");
    }
    QProcess stoprecording;
    void camera_recorder::stoprec() {
        //stoprecording.start("killall gst-launch-1.0");
        startrecording.kill();
        startrecording.waitForFinished(-1);
        //stoprecording.waitForFinished();
        playcam();
    }
    QProcess camstop;
    void camera_recorder::stopcam() {
        camstop.start("killall gst-launch-1.0");
    }
    int finished=2;
    QProcess video;
    void camera_recorder::startvideo() {
        camstart.kill();
        camstart.waitForFinished(-1);
        video.start("gst-launch-1.0 filesrc location=/home/root/output_video111.mkv ! matroskademux ! h264parse ! v4l2h264dec capture-io-mode=5 ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! waylandsink");
        finished=0;
        video.waitForFinished(-1);
        finished=1;
        //stopvideo();
        
    }
    QProcess stopVideo;
    void camera_recorder::stopvideo() {
        //stopVideo.start("killall gst-launch-1.0");
        video.kill();
        video.waitForFinished(-1);
        playcam();
    }
    int camera_recorder::isvideocomplete() {
        return finished;
    }