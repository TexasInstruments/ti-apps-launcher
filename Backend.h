#include <QObject>
#include <iostream>
#include <sstream>
#include <fstream>
#include <QCameraInfo>
#include <QStringListModel>

using namespace std;

static string cl_pipeline = "   multifilesrc location=/opt/edgeai-test-data/videos/video_0002_h264.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw, format=NV12 ! \
                                tiovxmultiscaler name=split_01 \
                                split_01. ! queue ! video/x-raw, width=454, height=256 ! tiovxdlcolorconvert out-pool-size=4 ! video/x-raw, format=RGB ! videobox left=115 right=115 top=16 bottom=16 ! tiovxdlpreproc data-type=3 channel-order=1 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/TFL-CL-0000-mobileNetV1-mlperf ! post_0.tensor \
                                split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                tidlpostproc name=post_0 model=/opt/model_zoo/TFL-CL-0000-mobileNetV1-mlperf alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                tiovxmosaic target=1 name=mosaic_0 \
                                sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Image Classification\" ! ";

static string od_pipeline = "   multifilesrc location=/opt/edgeai-test-data/videos/video_0000_h264.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                tiovxmultiscaler name=split_01 \
                                split_01. ! queue ! video/x-raw, width=320, height=320 ! tiovxdlpreproc data-type=3 channel-order=1 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/TFL-OD-2020-ssdLite-mobDet-DSP-coco-320x320 ! post_0.tensor \
                                split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                tidlpostproc name=post_0 model=/opt/model_zoo/TFL-OD-2020-ssdLite-mobDet-DSP-coco-320x320 alpha=0.400000 viz-threshold=0.600000 top-N=5 ! queue ! mosaic_0. \
                                tiovxmosaic target=1 name=mosaic_0 \
                                sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Object Detection\" ! ";

static string ss_pipeline = "   multifilesrc location=/opt/edgeai-test-data/videos/video_0000_h264.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                tiovxmultiscaler name=split_01 \
                                split_01. ! queue ! video/x-raw, width=512, height=512 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 ! post_0.tensor \
                                split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                tidlpostproc name=post_0 model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                tiovxmosaic target=1 name=mosaic_0 \
                                sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Semantic Segmentation \" ! ";

static std::string custom_template =    "title: \"Test Demo\"\n"
                                        "log_level: 2\n"
                                        "inputs:\n"
                                        "   input:\n"
                                        "       source: <source>\n"
                                        "       width: 1280\n"
                                        "       height: 720\n"
                                        "       framerate: 30\n"
                                        "       format: <format>\n"
                                        "       index: 0\n"
                                        "       subdev-id: 0\n"
                                        "       sen-id: \"\"\n"
                                        "       ldc: False\n"
                                        "models:\n"
                                        "   dl_model:\n"
                                        "       model_path: <model>\n"
                                        "outputs:\n"
                                        "   output:\n"
                                        "       sink: fakesink\n"
                                        "       width: 1920\n"
                                        "       height: 1080\n"
                                        "flows:\n"
                                        "    flow0: [input,dl_model,output,[320,180,1280,720]]\n";

class Backend : public QObject {
    Q_OBJECT

private:
    string pipeline;

    void addSink(string &pipeline, int xPos, int yPos, int width, int height) {
        /* tiovxmultiscaler only supports even resolution.*/
        if (width % 2 != 0)
            width++;
        if (height % 2 != 0)
            height++;

        if (width > 1920)
            width = 1920;
        if (height > 1080)
            height = 1080;

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
    }

    void generateYaml(QString userInputType, QString userInputFile, QString userModel) {
        string input = userInputFile.toStdString();
        string model = userModel.toStdString();
        string format = "";
        if (userInputType.toStdString() == "Camera") {
            format = "jpeg";
        } else if (userInputType.toStdString() == "Video") {
            format = "h264";
        }

        string config = replaceAll(replaceAll(replaceAll(custom_template,
                                              "<source>",input),
                                              "<format>",format),
                                              "<model>",model);

        ofstream custom_yaml("/tmp/custom_config.yaml");
        custom_yaml << config;
        custom_yaml.close();
    }

    string replaceAll(string str, const string &remove, const string &insert) {
        string::size_type pos = 0;
        while ((pos = str.find(remove, pos)) != string::npos) {
            str.replace(pos, remove.size(), insert);
            pos++;
        }

        return str;
    }

    string getPipelineString() {
        string command = "python3 /opt/edgeai-gst-apps/scripts/optiflow/optiflow.py /tmp/custom_config.yaml -t";
        array<char, 128> buffer;
        string result;
        unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
        if (!pipe) {
            throw std::runtime_error("popen() failed!");
        }
        while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
            result += buffer.data();
        }
        result = replaceAll(result,"gst-launch-1.0","gst-pipeline:");
        result = replaceAll(result,"\n","");

        return result;
    }

public:

    explicit Backend (QObject* parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE QString leftMenuButtonPressed(int button, int x, int y, int width, int height) {
        if (button == 1) {
            pipeline = "gst-pipeline: " + cl_pipeline;
            addSink(pipeline, x, y, width, height);
        } else if (button == 2) {           
            pipeline = "gst-pipeline: " + od_pipeline;
            addSink(pipeline, x, y, width, height);
            pipeline += " sync=false";
        } else if (button == 3) {
            pipeline = "gst-pipeline: " + ss_pipeline;
            addSink(pipeline, x, y, width, height);
            pipeline += " sync=false";
        } else {
            printf("WARNING: Invalid Button click from Left Menu!\n");
        }
        return QString().fromStdString(pipeline);
    }

    Q_INVOKABLE QString popupOkPressed(QString InputType, QString Input, QString Model, int x, int y, int width, int height) {
        cout << "Input Type = " << InputType.toStdString() << ";\nInput File = " << Input.toStdString() << ";\nModel = " << Model.toStdString() << endl;

        generateYaml(InputType, Input, Model);
        pipeline = getPipelineString();
        auto pos = pipeline.find_last_of("!");
        if ( pos != std::string::npos) {
            pipeline = pipeline.substr(0, pos);
            pipeline += " ! ";
        }

        addSink(pipeline, x, y, width, height);

        if (InputType.toStdString() != "Image")
        {
            pipeline += " sync=false";
        }

        cout << "Custom Pipeline: \n" << pipeline << endl;
        return QString().fromStdString(pipeline);
    }
};
