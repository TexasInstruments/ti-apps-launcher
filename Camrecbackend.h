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


class Camrecbackend : public QObject {
    Q_OBJECT

private:

public:

    QProcess camstart;
    Q_INVOKABLE void playcam() {   
        camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! waylandsink");
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

};
