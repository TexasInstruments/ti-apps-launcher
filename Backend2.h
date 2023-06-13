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


class Backend2 : public QObject {
    Q_OBJECT

private:

public:

    QProcess camstart;
    Q_INVOKABLE void playcam() {   
        camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw ! waylandsink");
    }
    QProcess startrecording1,startrecording;
    Q_INVOKABLE void startrec() {
        startrecording.start("killall gst-launch-1.0");
        startrecording.waitForFinished(-1);
        //startrecording.start("gst-launch-1.0 v4l2src device=/dev/video2 ! video/x-raw,width=640,height=480 ! x264enc ! mp4mux ! filesink location=test.mp4");
        startrecording.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! tee name=t t. ! queue ! jpegdec ! tiovxdlcolorconvert ! video/x-raw ! waylandsink t. ! queue ! filesink location=xyz.avi");
    }
    QProcess stoprecording;
    Q_INVOKABLE void stoprec() {
        stoprecording.start("killall gst-launch-1.0");
        stoprecording.waitForFinished();
        playcam();
    }
    QProcess camstop;
    Q_INVOKABLE void stopcam() {
        camstop.start("killall gst-launch-1.0");
    }

};
