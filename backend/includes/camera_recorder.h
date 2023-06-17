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


class camera_recorder : public QObject {
    Q_OBJECT

private:

public:

    //QProcess camstart;
    //Q_INVOKABLE void playcam() { 
    //    camstart.kill();  
    //    camstart.waitForFinished(-1);
    //    camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! waylandsink &");
    //    //camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw ! waylandsink &");
    //}
    //QProcess startrecording;
    //Q_INVOKABLE void startrec() {
    //    //startrecording.start("killall gst-launch-1.0");
    //    camstart.kill();
    //    camstart.waitForFinished(-1);
    //    //startrecording.waitForFinished(-1);
    //    startrecording.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw,format=NV12 ! tiovxmemalloc ! tee name=t t. ! queue ! waylandsink sync=False t. ! queue ! v4l2h264enc bitrate=10000000 ! h264parse ! matroskamux ! filesink sync=False location=/home/root/output_video111.mkv");
    //    //camstart.start("/home/root/run_recorder.sh");
    //}
    //QProcess stoprecording;
    //Q_INVOKABLE void stoprec() {
    //    //stoprecording.start("killall gst-launch-1.0");
    //    startrecording.kill();
    //    startrecording.waitForFinished(-1);
    //    //stoprecording.waitForFinished();
    //    playcam();
    //}
    //QProcess camstart;
    //Q_INVOKABLE void playcam() {
    //    camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! waylandsink &");
    //    //camstart.start("/home/root/run_recorder.sh");
    //}
    //Q_INVOKABLE void startrec() {
    //    camstart.kill();
    //    camstart.waitForFinished(-1);
    //    camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw,format=NV12 ! tiovxmemalloc ! tee name=t t. ! queue ! waylandsink sync=False t. ! queue ! v4l2h264enc bitrate=10000000 ! h264parse ! matroskamux ! filesink sync=False location=/home/root/output_video111.mkv");
    //}
    //Q_INVOKABLE void stoprec() {
    //    camstart.kill();
    //    camstart.waitForFinished(-1);
    //    playcam();
    //}
    //QProcess video;
    
    //QProcess camstop;
    //Q_INVOKABLE void stopcam() {
    //    camstop.start("killall gst-launch-1.0");
    //}
   


    QProcess camstart;
    Q_INVOKABLE void playcam() {   
        // camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! waylandsink");
        camstart.start("gst-launch-1.0 v4l2src device=/dev/video0 ! video/x-raw, width=640, height=480, format=UYVY ! waylandsink");
    }
    QProcess startrecording1,startrecording;
    Q_INVOKABLE void startrec() {
        //startrecording.start("killall gst-launch-1.0");
        camstart.kill();
        camstart.waitForFinished(-1);
        //startrecording.waitForFinished(-1);
        startrecording.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw,format=NV12 ! tiovxmemalloc ! tee name=t t. ! queue ! waylandsink sync=False t. ! queue ! v4l2h264enc bitrate=10000000 ! h264parse ! matroskamux ! filesink sync=False location=/home/root/output_video111.mkv");
    }
    QProcess stoprecording;
    Q_INVOKABLE void stoprec() {
        //stoprecording.start("killall gst-launch-1.0");
        startrecording.kill();
        startrecording.waitForFinished(-1);
        //stoprecording.waitForFinished();
        playcam();
    }
    QProcess camstop;
    Q_INVOKABLE void stopcam() {
        camstop.start("killall gst-launch-1.0");
    }
    int finished=2;
    QProcess video;
    Q_INVOKABLE void startvideo() {
        camstart.kill();
        camstart.waitForFinished(-1);
        video.start("gst-launch-1.0 filesrc location=/home/root/output_video111.mkv ! matroskademux ! h264parse ! v4l2h264dec capture-io-mode=5 ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! waylandsink");
        finished=0;
        video.waitForFinished(-1);
        finished=1;
        //stopvideo();
        
    }
    QProcess stopVideo;
    Q_INVOKABLE void stopvideo() {
        //stopVideo.start("killall gst-launch-1.0");
        video.kill();
        video.waitForFinished(-1);
        playcam();
    }
     Q_INVOKABLE int isvideocomplete() {
        return finished;
    }
};
