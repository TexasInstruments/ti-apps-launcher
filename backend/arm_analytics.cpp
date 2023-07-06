#include "includes/arm_analytics.h"
#include <QDebug>

QString object_detection_gst_pipeline = "gst-pipeline: multifilesrc location=/opt/oob-demo-assets/oob-gui-video1.h264 loop=true ! h264parse ! avdec_h264 ! ticolorconvert ! video/x-raw, format=NV12 ! tee name=tee_split0 tee_split0. ! queue ! tiscaler roi-startx=0 roi-starty=0 roi-width=1280 roi-height=720 ! video/x-raw, width=300, height=300 ! tidlpreproc model=/opt/model_zoo/TFL-OD-2010-ssd-mobV2-coco-mlperf-300x300  out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/TFL-OD-2010-ssd-mobV2-coco-mlperf-300x300 ! post_0.tensor tee_split0. ! queue ! post_0.sink tidlpostproc name=post_0 model=/opt/model_zoo/TFL-OD-2010-ssd-mobV2-coco-mlperf-300x300 viz-threshold=0.5 display-model=true ! video/x-raw,format=NV12, width=1280, height=720 ! qtvideosink sync=false";

QString face_detection_gst_pipeline = "gst-pipeline: multifilesrc location=/opt/oob-demo-assets/oob-gui-video2.h264 loop=true ! h264parse ! avdec_h264 ! ticolorconvert ! video/x-raw, format=NV12 ! tee name=tee_split0 tee_split0. ! queue ! tiscaler roi-startx=0 roi-starty=0 roi-width=1280 roi-height=720 ! video/x-raw, width=416, height=416 ! tidlpreproc model=/opt/model_zoo/ONR-OD-8410-yolox-tiny-lite-mmdet-widerface-416x416  out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer  model=/opt/model_zoo/ONR-OD-8410-yolox-tiny-lite-mmdet-widerface-416x416 ! post_0.tensor tee_split0. ! queue ! post_0.sink tidlpostproc name=post_0 model=/opt/model_zoo/ONR-OD-8410-yolox-tiny-lite-mmdet-widerface-416x416 viz-threshold=0.5 display-model=true ! video/x-raw,format=NV12, width=1280, height=720 ! qtvideosink sync=false";

QString image_classification_gst_pipeline = "gst-pipeline: multifilesrc location=/opt/oob-demo-assets/oob-gui-video1.h264 loop=true ! h264parse ! avdec_h264 ! ticolorconvert ! video/x-raw, format=NV12 ! tee name=tee_split0 tee_split0. ! queue ! tiscaler roi-startx=80 roi-starty=45 roi-width=1120 roi-height=630 ! video/x-raw, width=224, height=224 ! tidlpreproc model=/opt/model_zoo/ONR-CL-6360-regNetx-200mf  out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/ONR-CL-6360-regNetx-200mf ! post_0.tensor tee_split0. ! queue ! post_0.sink tidlpostproc name=post_0 model=/opt/model_zoo/ONR-CL-6360-regNetx-200mf top-N=5 display-model=true ! video/x-raw,format=NV12, width=1280, height=720 ! qtvideosink sync=true";

ArmAnalytics::ArmAnalytics() {
    return;
}

void ArmAnalytics::armAnalytics_update_gst_pipeline(QString model) {
    _model = model;
}

QString ArmAnalytics::armAnalytics_gst_pipeline() {
    if (_model == QStringLiteral("Image Classification"))
        gst_pipeline = image_classification_gst_pipeline;
    else if (_model == QStringLiteral("Object Detection"))
        gst_pipeline = object_detection_gst_pipeline;
    else if (_model == QStringLiteral("Face Detection"))
        gst_pipeline = face_detection_gst_pipeline;
    else
        qDebug() << "Doesn't match any model";

    qDebug() << gst_pipeline;
    return gst_pipeline;
}


