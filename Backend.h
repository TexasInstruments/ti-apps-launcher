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

static string cl_pipeline = "   multifilesrc location=/opt/oob-demo-assets/oob-gui-video1.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw, format=NV12 ! \
                                tiovxmultiscaler name=split_01 \
                                split_01. ! queue ! video/x-raw, width=454, height=256 ! tiovxdlcolorconvert out-pool-size=4 ! video/x-raw, format=RGB ! videobox left=115 right=115 top=16 bottom=16 ! tiovxdlpreproc data-type=3 channel-order=1 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/TFL-CL-0000-mobileNetV1-mlperf ! post_0.tensor \
                                split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                tidlpostproc name=post_0 model=/opt/model_zoo/TFL-CL-0000-mobileNetV1-mlperf alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                tiovxmosaic target=1 name=mosaic_0 \
                                sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Image Classification\" ! ";

static string am62a_od_pipeline = "   multifilesrc location=/opt/oob-demo-assets/oob-gui-video2.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                      tiovxmultiscaler name=split_01 \
                                      split_01. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_0.tensor \
                                      split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                      tidlpostproc name=post_0 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                      tiovxmosaic target=1 name=mosaic_0 \
                                      sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                      ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Object Detection\" ! ";

static string am62a_ss_pipeline = "   multifilesrc location=/opt/oob-demo-assets/oob-gui-video3.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                      tiovxmultiscaler name=split_01 \
                                      split_01. ! queue ! video/x-raw, width=512, height=512 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 ! post_0.tensor \
                                      split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                      tidlpostproc name=post_0 model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                      tiovxmosaic target=1 name=mosaic_0 \
                                      sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                      ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Semantic Segmentation \" ! ";
static string j721s2_od_pipeline = "    multifilesrc location=/opt/oob-demo-assets/oob-gui-video2.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_01 \
                                        split_01. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_0.tensor \
                                        split_01. ! queue ! video/x-raw, width=640, height=360 ! post_0.sink \
                                        tidlpostproc name=post_0 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        multifilesrc location=/opt/oob-demo-assets/oob-gui-video3.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_11 \
                                        split_11. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_1.tensor \
                                        split_11. ! queue ! video/x-raw, width=640, height=360 ! post_1.sink \
                                        tidlpostproc name=post_1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        multifilesrc location=/opt/oob-demo-assets/oob-gui-video4.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_21 \
                                        split_21. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_2.tensor \
                                        split_21. ! queue ! video/x-raw, width=640, height=360 ! post_2.sink \
                                        tidlpostproc name=post_2 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        multifilesrc location=/opt/oob-demo-assets/oob-gui-video5.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_31 \
                                        split_31. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_3.tensor \
                                        split_31. ! queue ! video/x-raw, width=640, height=360 ! post_3.sink \
                                        tidlpostproc name=post_3 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        \
                                        tiovxmosaic target=1 name=mosaic_0 \
                                        sink_0::startx=\"<320>\"  sink_0::starty=\"<150>\"  sink_0::widths=\"<640>\"   sink_0::heights=\"<360>\"  \
                                        sink_1::startx=\"<960>\"  sink_1::starty=\"<150>\"  sink_1::widths=\"<640>\"   sink_1::heights=\"<360>\"  \
                                        sink_2::startx=\"<320>\"  sink_2::starty=\"<510>\"  sink_2::widths=\"<640>\"   sink_2::heights=\"<360>\"  \
                                        sink_3::startx=\"<960>\"  sink_3::starty=\"<510>\"  sink_3::widths=\"<640>\"   sink_3::heights=\"<360>\"  \
                                        ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Object Detection\" ! ";

static string j721s2_ss_pipeline = "   multifilesrc location=/opt/oob-demo-assets/oob-gui-video6.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                       tiovxmultiscaler name=split_01 \
                                       split_01. ! queue ! video/x-raw, width=512, height=512 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 ! post_0.tensor \
                                       split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                       tidlpostproc name=post_0 model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                       tiovxmosaic target=1 name=mosaic_0 \
                                       sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                       ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Semantic Segmentation \" ! ";

static string j721e_od_pipeline = "    multifilesrc location=/opt/oob-demo-assets/oob-gui-video2.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec capture-io-mode=5 ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_01 \
                                        split_01. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_0.tensor \
                                        split_01. ! queue ! video/x-raw, width=640, height=360 ! post_0.sink \
                                        tidlpostproc name=post_0 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        multifilesrc location=/opt/oob-demo-assets/oob-gui-video3.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec capture-io-mode=5 ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_11 \
                                        split_11. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_1.tensor \
                                        split_11. ! queue ! video/x-raw, width=640, height=360 ! post_1.sink \
                                        tidlpostproc name=post_1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        multifilesrc location=/opt/oob-demo-assets/oob-gui-video4.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec capture-io-mode=5 ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_21 \
                                        split_21. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_2.tensor \
                                        split_21. ! queue ! video/x-raw, width=640, height=360 ! post_2.sink \
                                        tidlpostproc name=post_2 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        multifilesrc location=/opt/oob-demo-assets/oob-gui-video5.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec capture-io-mode=5 ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                        tiovxmultiscaler name=split_31 \
                                        split_31. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_3.tensor \
                                        split_31. ! queue ! video/x-raw, width=640, height=360 ! post_3.sink \
                                        tidlpostproc name=post_3 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                        \
                                        \
                                        tiovxmosaic target=1 name=mosaic_0 \
                                        sink_0::startx=\"<320>\"  sink_0::starty=\"<150>\"  sink_0::widths=\"<640>\"   sink_0::heights=\"<360>\"  \
                                        sink_1::startx=\"<960>\"  sink_1::starty=\"<150>\"  sink_1::widths=\"<640>\"   sink_1::heights=\"<360>\"  \
                                        sink_2::startx=\"<320>\"  sink_2::starty=\"<510>\"  sink_2::widths=\"<640>\"   sink_2::heights=\"<360>\"  \
                                        sink_3::startx=\"<960>\"  sink_3::starty=\"<510>\"  sink_3::widths=\"<640>\"   sink_3::heights=\"<360>\"  \
                                        ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Object Detection\" ! ";

static string j721e_ss_pipeline = "   multifilesrc location=/opt/oob-demo-assets/oob-gui-video6.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                       tiovxmultiscaler name=split_01 \
                                       split_01. ! queue ! video/x-raw, width=512, height=512 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 ! post_0.tensor \
                                       split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                       tidlpostproc name=post_0 model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                       tiovxmosaic target=1 name=mosaic_0 \
                                       sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                       ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Semantic Segmentation \" ! ";

static string j784s4_od_pipeline = "multifilesrc location=/opt/oob-demo-assets/oob-gui-video2.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=0 name=split_01 \
                                    split_01. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_0.tensor \
                                    split_01. ! queue ! video/x-raw, width=640, height=360 ! post_0.sink \
                                    tidlpostproc name=post_0 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video3.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=1 name=split_11 \
                                    split_11. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=2 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_1.tensor \
                                    split_11. ! queue ! video/x-raw, width=640, height=360 ! post_1.sink \
                                    tidlpostproc name=post_1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video4.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=2 name=split_21 \
                                    split_21. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=3 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_2.tensor \
                                    split_21. ! queue ! video/x-raw, width=640, height=360 ! post_2.sink \
                                    tidlpostproc name=post_2 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video5.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=3 name=split_31 \
                                    split_31. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=4 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_3.tensor \
                                    split_31. ! queue ! video/x-raw, width=640, height=360 ! post_3.sink \
                                    tidlpostproc name=post_3 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video6.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2video2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=0 name=split_41 \
                                    split_41. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=1 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_4.tensor \
                                    split_41. ! queue ! video/x-raw, width=640, height=360 ! post_4.sink \
                                    tidlpostproc name=post_4 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video7.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2video2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=1 name=split_51 \
                                    split_51. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=2 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_5.tensor \
                                    split_51. ! queue ! video/x-raw, width=640, height=360 ! post_5.sink \
                                    tidlpostproc name=post_5 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video8.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2video2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=2 name=split_61 \
                                    split_61. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=3 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_6.tensor \
                                    split_61. ! queue ! video/x-raw, width=640, height=360 ! post_6.sink \
                                    tidlpostproc name=post_6 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    multifilesrc location=/opt/oob-demo-assets/oob-gui-video9.h264 loop=true stop-index=0 caps=video/x-h264,width=1280,height=720,framerate=30/1 ! h264parse ! v4l2video2h264dec ! tiovxmemalloc pool-size=8 ! video/x-raw, format=NV12 ! \
                                    tiovxmultiscaler target=3 name=split_71 \
                                    split_71. ! queue ! video/x-raw, width=416, height=416 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=bgr out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer target=4 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 ! post_7.tensor \
                                    split_71. ! queue ! video/x-raw, width=640, height=360 ! post_7.sink \
                                    tidlpostproc name=post_7 model=/opt/model_zoo/ONR-OD-8200-yolox-nano-lite-mmdet-coco-416x416 alpha=0.450000 viz-threshold=0.450000 top-N=5 ! queue ! mosaic_0. \
                                    \
                                    \
                                    tiovxmosaic target=1 src::pool-size=3 name=mosaic_0 \
                                    sink_0::startx=\"<213>\"  sink_0::starty=\"<50>\"  sink_0::widths=\"<498>\"   sink_0::heights=\"<280>\"  \
                                    sink_1::startx=\"<711>\"  sink_1::starty=\"<50>\"  sink_1::widths=\"<498>\"   sink_1::heights=\"<280>\"  \
                                    sink_2::startx=\"<1209>\"  sink_2::starty=\"<50>\"  sink_2::widths=\"<498>\"   sink_2::heights=\"<280>\"  \
                                    sink_3::startx=\"<213>\"  sink_3::starty=\"<330>\"  sink_3::widths=\"<498>\"   sink_3::heights=\"<280>\"  \
                                    sink_4::startx=\"<711>\"  sink_4::starty=\"<330>\"  sink_4::widths=\"<498>\"   sink_4::heights=\"<280>\"  \
                                    sink_5::startx=\"<1209>\"  sink_5::starty=\"<330>\"  sink_5::widths=\"<498>\"   sink_5::heights=\"<280>\"  \
                                    sink_6::startx=\"<462>\"  sink_6::starty=\"<610>\"  sink_6::widths=\"<498>\"   sink_6::heights=\"<280>\"  \
                                    sink_7::startx=\"<960>\"  sink_7::starty=\"<610>\"  sink_7::widths=\"<498>\"   sink_7::heights=\"<280>\"  \
                                    ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Object Detection\" ! ";

static string j784s4_ss_pipeline = "   multifilesrc location=/opt/oob-demo-assets/oob-gui-video10.h264 loop=true caps=\"video/x-h264, width=1280, height=720\" ! h264parse ! v4l2h264dec ! video/x-raw,format=NV12 ! \
                                       tiovxmultiscaler name=split_01 \
                                       split_01. ! queue ! video/x-raw, width=512, height=512 ! tiovxdlpreproc data-type=3 channel-order=0 tensor-format=rgb out-pool-size=4 ! application/x-tensor-tiovx ! tidlinferer model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 ! post_0.tensor \
                                       split_01. ! queue ! video/x-raw, width=1280, height=720 ! post_0.sink \
                                       tidlpostproc name=post_0 model=/opt/model_zoo/ONR-SS-8610-deeplabv3lite-mobv2-ade20k32-512x512 alpha=0.400000 viz-threshold=0.500000 top-N=5 ! queue ! mosaic_0. \
                                       tiovxmosaic target=1 name=mosaic_0 \
                                       sink_0::startx=\"<320>\"  sink_0::starty=\"<180>\"  sink_0::widths=\"<1280>\"   sink_0::heights=\"<720>\"  \
                                       ! video/x-raw,format=NV12, width=1920, height=1080 ! queue ! tiperfoverlay main-title=null title=\"Semantic Segmentation \" ! ";

static std::string custom_template =    "title: <title>\n"
                                        "log_level: 2\n"
                                        "inputs:\n"
                                        "   input:\n"
                                        "       source: <source>\n"
                                        "       width: <width>\n"
                                        "       height: <height>\n"
                                        "       framerate: 30\n"
                                        "       format: <format>\n"
                                        "       index: 0\n"
                                        "       subdev-id: <subdev-id>\n"
                                        "       sen-id: <sen-id>\n"
                                        "       ldc: <ldc>\n"
                                        "       loop: True\n"
                                        "models:\n"
                                        "   dl_model:\n"
                                        "       model_path: <model>\n"
                                        "outputs:\n"
                                        "   output:\n"
                                        "       sink: fakesink\n"
                                        "       width: 1920\n"
                                        "       height: 1080\n"
                                        "       overlay-performance: True\n"
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
        string config;
        string title = "Custom";
        string width = "1280";
        string height = "720";
        string format = "jpeg";
        string subdev_id = "0";
        string sen_id = "null";
        string ldc = "False";
        string input = userInputFile.toStdString();
        string model = userModel.toStdString();
        string modelName = model.substr(model.find_last_of("/\\") + 1);
        if (userInputType.toStdString() == "Camera") {

            map<string, map<string,string>> cameraInfo;
            getCameraInfo(cameraInfo);

            title = input + "->" + modelName;

            string deviceKey = "device";

            if (input.find("RGB") != string::npos) {
                input = replaceAll(input,"RGB","");
                deviceKey += " RGB";
            }
            else if (input.find("IR") != string::npos) {
                input = replaceAll(input,"IR","");
                deviceKey += " IR";
            }

            input = trimString(input);
            map<string,string> cameraData = cameraInfo[input];

            if (cameraData.find("subdev_id") != cameraData.end()) {
                subdev_id = replaceAll(cameraData["subdev_id"],"/dev/v4l-subdev","");
                subdev_id = trimString(subdev_id);
            }
            if (cameraData.find("name") != cameraData.end())
                sen_id = cameraData["name"];
            if (cameraData.find("ldc_required") != cameraData.end() &&
                cameraData["ldc_required"] == "yes")
                ldc = "True";

            if (input.find("USB") != string::npos)
                format = cameraData["format"];
            else if (sen_id == "ov2312") {
                width = "1600";
                height = "1300";
                format = "bggi10";
            }
            else if (sen_id == "imx390") {
                width = "1936";
                height = "1100";
                format = "rggb12";
            }
            else if (sen_id == "imx219") {
                width = "1920";
                height = "1080";
                format = "rggb";
            }
            else
                format = "auto";

            input = cameraData[deviceKey];


        } else {
            string fileName = input.substr(input.find_last_of("/\\") + 1);
            title = fileName + "->" + modelName;

            if (userInputType.toStdString() == "Video") {
                if (input.find("h265") != string::npos)
                    format = "h265";
                else
                    format = "h264";

                //Get width and height of input file
                string command = "ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 " + input;

                // ffprobe is not present in am62a
                if (soc == "am62a")
                {
                    command = "w=`gst-discoverer-1.0 "+input+" -v | grep Width` && "
                              "h=`gst-discoverer-1.0 "+input+" -v | grep Height` && "
                              "echo ${w#*:} x ${h#*:}";
                }
                array<char, 128> buffer;
                string result;
                unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
                if (!pipe) {
                    throw std::runtime_error("popen() failed!");
                }
                while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
                    result += buffer.data();
                }
                char *token;
                token = strtok(&result[0],"x");
                width = trimString(token);
                token =  strtok(NULL,"x");
                height = trimString(token);
            }
        }

        config = replaceAll(custom_template,"<title>",title);
        config = replaceAll(config,"<source>",input);
        config = replaceAll(config,"<width>",width);
        config = replaceAll(config,"<height>",height);
        config = replaceAll(config,"<format>",format);
        config = replaceAll(config,"<subdev-id>",subdev_id);
        config = replaceAll(config,"<sen-id>",sen_id);
        config = replaceAll(config,"<ldc>",ldc);
        config = replaceAll(config,"<model>",model);

        ofstream custom_yaml("/tmp/custom_config.yaml");
        custom_yaml << config;
        custom_yaml.close();
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
        result = replaceAll(result,"tiperfoverlay","tiperfoverlay main-title=null");
        result = replaceAll(result,"\n","");
        return result;
    }

    QString ip_addr_p;

public:
    string soc;

    Q_PROPERTY(QString ip_addr READ ip_addr WRITE set_ip_addr NOTIFY ip_addr_changed)

    Q_INVOKABLE QString ip_addr() {
        return ip_addr_p;
    }

    void set_ip_addr(QString ip_addr_n) {
        ip_addr_p = ip_addr_n;
        emit ip_addr_changed();
    }

    explicit Backend (QObject* parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE QString leftMenuButtonPressed(int button, int x, int y, int width, int height) {
        printf("%s\n",soc.c_str());

        string od_pipeline;
        string ss_pipeline;
        if (soc == "am62a")
        {
            od_pipeline = am62a_od_pipeline;
            ss_pipeline = am62a_ss_pipeline;
        }
        else if (soc == "j721s2")
        {
            od_pipeline = j721s2_od_pipeline;
            ss_pipeline = j721s2_ss_pipeline;
        }
        else if (soc == "j721e")
        {
            od_pipeline = j721e_od_pipeline;
            ss_pipeline = j721e_ss_pipeline;
        }
        else if (soc == "j784s4")
        {
            od_pipeline = j784s4_od_pipeline;
            ss_pipeline = j784s4_ss_pipeline;
        }

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

    QProcess camstart;
    Q_INVOKABLE void playcam() {   
        camstart.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=640, height=480 ! jpegdec ! tiovxdlcolorconvert ! video/x-raw ! waylandsink");
    }
    QProcess startrecording1,startrecording;
    Q_INVOKABLE void startrec() {
        startrecording.start("killall gst-launch-1.0");
        startrecording.waitForFinished(-1);
        startrecording.start("gst-launch-1.0 v4l2src device=/dev/video2 ! image/jpeg, width=1280, height=720 ! tee name=t t. ! queue ! jpegdec ! tiovxdlcolorconvert ! video/x-raw ! waylandsink t. ! queue ! filesink location=xyz.mp4");
    }
    QProcess stoprecording;
    Q_INVOKABLE void stoprec() {
        stoprecording.start("killall gst-launch-1.0");
        stoprecording.waitForFinished();
        playcam();
    }
    QProcess camstop;
    Q_INVOKABLE void stopcam()
    {
        camstop.start("killall gst-launch-1.0");
    }

    Q_INVOKABLE QString getgpuload(){
        QProcess process;
        process.start("cat /sys/kernel/debug/pvr/status");
        process.waitForFinished(-1);
        QString output = process.readAllStandardOutput();

        return output.mid(output.indexOf("GPU Utilisation")+17,output.indexOf("%")-output.indexOf("GPU Utilisation")-17);
    }
    Q_INVOKABLE QString getcpuload(){
        QProcess process;
        process.start("cat /proc/stat");
        process.waitForFinished(-1);
        QString cpuoutput = process.readAllStandardOutput();
        int spc=0;
        int totaltime=0,idletime=0;
        int curr=0,i;
        for(i=0;i<cpuoutput.length();i++)
        {
            QChar c= cpuoutput.at(i);
            if(c==" "||c=='\n')
            {spc++;
             totaltime+=curr;
             if(spc==6||spc==7)
             idletime+=curr;
             curr=0;
             
            }
            if(c=="\n")
            break;
            if(c.isDigit())
            {
                int d = QString(c).toInt();
                curr*=10;curr+=d;
            }
        }
        qDebug()<<idletime<<totaltime;
        double load = (totaltime-idletime)/totaltime;
        load*=100;
        QString res = QString::number(load);
        return res;
    }

    QString stdout1,stdout11;
    QProcess process1,process11;
    Q_INVOKABLE void playbutton1pressed()
    {
        process1.start("glmark2-es2-wayland");
       //process1.start("glmark2-es2-wayland");
    }
    
    Q_INVOKABLE void playbutton1pressedagain()
    {
        process11.start("killall glmark2-es2-wayland");
        process11.waitForFinished();
        stdout11= process11.readAllStandardOutput();
    }
    Q_INVOKABLE QString playbutton1fps()
    {
        stdout1 = process1.readAllStandardOutput();
        qDebug()<<stdout1;
        return stdout1.mid(stdout1.indexOf("FPS")+7,6);
    }
    Q_INVOKABLE QString playbutton1score()
    {
        //stdout11= process11.readAllStandardOutput();
        //qDebug()<<stdout11;
        return stdout1.mid(stdout1.indexOf("Score")+7,5);
    }
    
    //gpuperformance
    QProcess load0,load1,load2,load3,load4;
    Q_INVOKABLE void gpuload0(){
        load0.start("killall glmark2-es2-wayland");
    }
    Q_INVOKABLE void gpuload1(){
        load1.start("killall glmark2-es2-wayland");
        load1.waitForFinished();
        load1.start("glmark2-es2-wayland -b buffer:duration=100");
    }
    Q_INVOKABLE void gpuload2(){
        load2.start("killall glmark2-es2-wayland");
        load2.waitForFinished();
        load2.start("glmark2-es2-wayland -b ideas:duration=100");
    }
    Q_INVOKABLE void gpuload3(){
        load3.start("killall glmark2-es2-wayland");
        load3.waitForFinished();
        load3.start("/home/root/jacinto_oob/gpu_load_level_3.sh");
    }
    Q_INVOKABLE void gpuload4(){
        load4.start("killall glmark2-es2-wayland");
        load4.waitForFinished();
        load4.start("/home/root/jacinto_oob/gpu_load_level_4.sh");
    }

    string replaceAll(string str, const string &remove, const string &insert) {
        string::size_type pos = 0;
        while ((pos = str.find(remove, pos)) != string::npos) {
            str.replace(pos, remove.size(), insert);
            pos++;
        }

        return str;
    }

    string trimString(string str)
    {
        string stripString = str;
        while(!stripString.empty() && isspace(*stripString.begin()))
            stripString.erase(stripString.begin());

        while(!stripString.empty() && isspace(*stripString.rbegin()))
            stripString.erase(stripString.length()-1);

        return stripString;
    }

    void getCameraInfo(map<string, map<string,string>> &cameraInfo)
    {
        // Get camera info from setup_camera script
        string command = "bash /opt/edgeai-gst-apps/scripts/setup_cameras.sh";
        array<char, 128> buffer;
        string result;
        unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
        if (!pipe) {
            throw std::runtime_error("popen() failed!");
        }
        while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
            result += buffer.data();
        }

        vector<string> split_string{};
        auto ss = stringstream{result};
        unsigned int i,j;

        for (string line; getline(ss, line, '\n');)
            split_string.push_back(line);

        for(i = 0; i < split_string.size(); i++) {
            if (split_string[i].find("detected") != string::npos) {
                string cameraName = replaceAll(split_string[i],"detected","");
                cameraName = trimString(cameraName);

                map<string, string> info{};
                for (j = i+1; j < split_string.size(); j++) {
                    if (split_string[j].find("detected") != string::npos)
                        break;

                    char *token;
                    token = strtok(&split_string[j][0], "=");
                    string key = trimString(token);
                    token =  strtok(NULL, "=");
                    string value = trimString(token);
                    info[key] = value;
                }
                if (info.size() > 0)
                    cameraInfo[cameraName] = info;
            }
        }
    }

signals:
    void ip_addr_changed();
};
