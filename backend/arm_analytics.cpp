#include "includes/arm_analytics.h"
#include "includes/common.h"
#include <QDebug>
#include <QQuickItem>

#include <gst/gst.h>

QString object_detection_gst_pipeline = "\
    multifilesrc location=/usr/share/oob-demo-assets/videos/oob-gui-video-objects.h264 loop=true ! \
    h264parse ! avdec_h264 ! \
    videoconvert ! video/x-raw,format=RGB ! \
    tee name=tee_split0 \
    tee_split0. ! \
        queue ! \
        videoscale ! video/x-raw,width=300,height=300 ! \
        tensor_converter ! \
        tensor_transform mode=arithmetic option=typecast:float32,add:-127.5,div:127.5 ! \
        tensor_filter framework=tensorflow2-lite model=/usr/share/oob-demo-assets/models/ssd_mobilenet_v2_coco.tflite custom=Delegate:XNNPACK,NumThreads:4 latency=1 ! \
        tensor_decoder \
        mode=bounding_boxes \
            option1=mobilenet-ssd \
            option2=/usr/share/oob-demo-assets/labels/coco_labels.txt \
            option3=/usr/share/oob-demo-assets/labels/box_priors.txt \
            option4=1280:720 \
            option5=300:300 ! \
        mix.sink_0 \
    tee_split0. ! \
        queue ! \
        mix.sink_1 \
    compositor name=mix sink_0::zorder=2 sink_1::zorder=1 ! \
    glupload ! qml6glsink name=sink";

QString image_classification_gst_pipeline = "\
    multifilesrc location=/usr/share/oob-demo-assets/videos/oob-gui-video-objects.h264 loop=true ! \
    h264parse ! avdec_h264 ! \
    tee name=tee_split0 \
    tee_split0. ! \
        queue ! \
        videoconvert ! videoscale ! video/x-raw,width=224,height=224,format=BGR ! \
        tensor_converter ! \
        tensor_transform mode=transpose option=1:2:0:3 ! \
        tensor_filter framework=onnxruntime model=/usr/share/oob-demo-assets/models/regnetx-200mf.onnx ! \
        tensor_decoder \
            mode=image_labeling \
            option1=/usr/share/oob-demo-assets/labels/squeezenet_labels.txt ! \
        overlay.text_sink \
    tee_split0. ! \
        queue ! \
        videoconvert ! video/x-raw,format=RGB ! \
        overlay.video_sink \
    textoverlay name=overlay font-desc=Sans,24 ! \
    glupload ! qml6glsink name=sink";

void ArmAnalytics::startVideo(QObject* object, QString model) {
    QString gst_pipeline;
    if (model == QStringLiteral("Image Classification"))
        gst_pipeline = image_classification_gst_pipeline;
    else if (model == QStringLiteral("Object Detection"))
        gst_pipeline = object_detection_gst_pipeline;
    else {
        qDebug() << "Doesn't match any model";
        return;
    }

    if (detected_device == AM62PXX_EVM) {
        gst_pipeline.replace("avdec_h264", "v4l2h264dec capture-io-mode=4");
        gst_pipeline.replace("loop=true", "loop=true caps=video/x-h264,width=1280,height=720,framerate=1/1");
    }

    GError *error = NULL;
    pipeline = gst_parse_launch (gst_pipeline.toLatin1().data(), &error);
    if (error) {
        g_printerr("Failed to parse launch: %s\n", error->message);
        g_error_free(error);
        return;
    }

    /* find and set the videoItem on the sink */
    GstElement *sink = gst_bin_get_by_name( GST_BIN( pipeline ), "sink" );
    g_assert(sink);
    QQuickItem *videoItem = qobject_cast<QQuickItem*>(object);
    g_assert(videoItem);
    g_object_set(sink, "widget", videoItem, NULL);

    qDebug() << "Starting video";
    gst_element_set_state(pipeline, GST_STATE_PLAYING);
}

void ArmAnalytics::stopVideo()
{
    if (pipeline) {
        qDebug() << "Stopping video";
        gst_element_set_state (pipeline, GST_STATE_NULL);
        qDebug() << "Removing pipeline";
        gst_object_unref (pipeline);
        pipeline = NULL;
    }
}
