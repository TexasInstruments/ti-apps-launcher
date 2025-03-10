#include "includes/arm_analytics.h"
#include "includes/common.h"
#include <QDebug>
#include <QQuickItem>

#include <gst/gst.h>

QString object_detection_gst_pipeline = "\
    multifilesrc location=/opt/oob-demo-assets/oob-gui-video1.h264 loop=true ! \
    h264parse ! avdec_h264 ! \
    videoconvert ! video/x-raw,format=RGB ! \
    tee name=tee_split0 \
    tee_split0. ! \
        queue ! \
        videoscale ! video/x-raw,width=300,height=300 ! \
        tensor_converter ! \
        tensor_transform mode=arithmetic option=typecast:float32,add:-127.5,div:127.5 ! \
        tensor_filter framework=tensorflow2-lite model=/opt/oob-demo-assets/ssd_mobilenet_v2_coco/ssd_mobilenet_v2_coco.tflite custom=Delegate:XNNPACK,NumThreads:4 latency=1 ! \
        tensor_decoder \
        mode=bounding_boxes \
            option1=mobilenet-ssd \
            option2=/opt/oob-demo-assets/ssd_mobilenet_v2_coco/coco_labels_list.txt \
            option3=/opt/oob-demo-assets/ssd_mobilenet_v2_coco/box_priors.txt \
            option4=1280:720 \
            option5=300:300 ! \
        mix.sink_0 \
    tee_split0. ! \
        queue ! \
        mix.sink_1 \
    compositor name=mix sink_0::zorder=2 sink_1::zorder=1 ! \
    qml6glsink name=sink";

QString face_detection_gst_pipeline = "\
    multifilesrc location=/opt/oob-demo-assets/oob-gui-video2.h264 loop=true ! \
    h264parse ! avdec_h264 ! \
    tee name=tee_split0 \
    tee_split0. ! \
        queue ! \
        videoscale ! video/x-raw,width=416,height=416 ! \
        tensor_converter ! \
        tensor_transform mode=arithmetic option=typecast:float32,add:-127.5,div:127.5 ! \
        tensor_filter framework=onnxruntime model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416/model.onnx ! \
        tensor_decoder \
        mode=bounding_boxes \
            option1=mobilenet-ssd \
            option2=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416/labels_list.txt \
            option3=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416/box_priors.txt \
            option4=1280:720 \
            option5=300:300 ! \
        mix.sink_0 \
    tee_split0. ! \
        queue ! \
        mix.sink_1 \
    compositor name=mix sink_0::zorder=2 sink_1::zorder=1 ! \
    qml6glsink name=sink";

QString image_classification_gst_pipeline = "\
    multifilesrc location=/opt/oob-demo-assets/oob-gui-video1.h264 loop=true ! \
    h264parse ! avdec_h264 ! \
    tee name=tee_split0 \
    tee_split0. ! \
        queue ! \
        videoconvert ! videoscale ! video/x-raw,width=224,height=224,format=BGR ! \
        tensor_converter ! \
        tensor_transform mode=transpose option=1:2:0:3 ! \
        tensor_filter framework=onnxruntime model=/opt/model_zoo/ONR-CL-6360-regNetx-200mf/model/regnetx-200mf.onnx ! \
        tensor_decoder mode=image_labeling option1=/opt/model_zoo/ONR-CL-6360-regNetx-200mf/labels/squeezenet_labels.txt ! \
        overlay.text_sink \
    tee_split0. ! \
        queue ! \
        overlay.video_sink \
    textoverlay name=overlay font-desc=Sans,24 ! \
    qml6glsink name=sink";

void ArmAnalytics::startVideo(QObject* object, QString model) {
    QString gst_pipeline;
    if (model == QStringLiteral("Image Classification"))
        gst_pipeline = image_classification_gst_pipeline;
    else if (model == QStringLiteral("Object Detection"))
        gst_pipeline = object_detection_gst_pipeline;
    else if (model == QStringLiteral("Face Detection"))
        gst_pipeline = face_detection_gst_pipeline;
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
    g_assert (videoItem);
    qDebug() << "got videoItem";
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
