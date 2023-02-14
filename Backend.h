#include <QObject>
#include <QDebug>
#include <iostream>
#include <sstream>
#include <QCameraInfo>

using namespace std;

static string od_pipeline = "multifilesrc location=/opt/edgeai-test-data/videos/video_0000_h264.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! \
                                  h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                  tiovxmosaic sink_0::startx=\"<320>\" sink_0::starty=\"<180>\" sink_0::widths=\"<1280>\" sink_0::heights=\"<720>\" ! \
                                  video/x-raw, width=1920, height=1080 ! queue ! tiperfoverlay title=\"Object Detection Demo\" ! ";

class ButtonsClicked : public QObject {
    Q_OBJECT
public:
    static int activeButton;
    string pipeline;

    Q_PROPERTY(int activeButton READ getActiveButton NOTIFY activeButtonChanged);

    int getActiveButton() const {
        return activeButton;
    };

    explicit ButtonsClicked (QObject* parent = nullptr) : QObject(parent) {}

    void addSink(string &pipeline, int xPos, int yPos, int width, int height)
    {
        /* tiovxmultiscaler only supports even resolution.*/
        if (width % 2 != 0) {
            width++;
        }
        if (height % 2 != 0) {
            height++;
        }

        if (width > 1920) {
            width = 1920;
        }
        if (height > 1080) {
            height = 1080;
        }

        if (width < 1920 || height < 1080 ) {
            pipeline += "tiovxmultiscaler ! "
                        "video/x-raw, "
                        "width=" +
                        std::to_string(width) +
                        ",height=" +
                        std::to_string(height) +
                        " ! ";
        }

        pipeline += "kmssink driver-name=tidss name=\"qtvideosink\" "
                    "render-rectangle=\""
                    "<" +
                    std::to_string(xPos) +
                    "," +
                    std::to_string(yPos) +
                    "," +
                    std::to_string(width) +
                    "," +
                    std::to_string(height) +
                    ">\"";
        /*
        if (demoId != 1 && customInputIsImage == false)
        {
            pipeline += " sync=false";
        }
        else
        {
            pipeline += " sync=true";
        }
        */
    }

    Q_INVOKABLE QString leftMenuButtonClicked(int button, int x, int y, int width, int height) {
        cout << "c++ button value = " << button << endl;
        activeButton = button;

        cout << "c++ active button value = " << activeButton << endl;
        if (button == 1) {
            // pipeline << "gst-pipeline: videotestsrc pattern=18 ! videoconvert ! videoscale ! capsfilter caps=\"video/x-raw, width=" << width << ", height=" << height << "\" ! qtvideosink";
            pipeline = "gst-pipeline: " + od_pipeline;
            addSink(pipeline, x, y, width, height);
        } else if (button == 2) {           
            // pipeline << "gst-pipeline: videotestsrc pattern=18 ! videoconvert ! videoscale ! capsfilter caps=\"video/x-raw, width=" << width << ", height=" << height << "\" ! qtvideosink";
            pipeline = "gst-pipeline: " + od_pipeline;
            addSink(pipeline, x, y, width, height);
        } else if (button == 3) {
            // pipeline << "gst-pipeline: videotestsrc pattern=18 ! videoconvert ! videoscale ! capsfilter caps=\"video/x-raw, width=" << width << ", height=" << height << "\" ! qtvideosink";
            pipeline = "gst-pipeline: " + od_pipeline;
            addSink(pipeline, x, y, width, height);
        } else if (button >= 4) {
            printf("WARNING: Button functionality not implemented\n");
        } else {
            printf("WARNING: Invalid Button click from Left Menu!\n");
        }
        cout << "pipeline is: \n" << pipeline << endl;
        return QString().fromStdString(pipeline);
    }
signals:
    void activeButtonChanged();
};

class PopupMenu : public QObject {
    Q_OBJECT
public:

    explicit PopupMenu (QObject* parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void popupInputTypeSelected(QString InputType) {
            qDebug() << "Input Type = " << InputType.data() << Qt::endl;
    }
signals:
    void cameraListChanged();
    void cameraNamesChanged();
};
