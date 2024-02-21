#include <QObject>
#include <iostream>

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <sstream>
#include <fstream>
#include <map>
#include <QStringListModel>
#include <QProcess>
#include <QDebug>
#include<QMediaPlayer>
using namespace std;


class Camera : public QObject {
    Q_OBJECT

private:

    map<string, map<string,string>> cameraInfo;
    QString _camera;
    QString _videofile;

    string replaceAll(string str, const string &remove, const string &insert);
    string trimString(string str);

public:

    QStringListModel Camera_list;
    int Camera_count;
    QString gst_pipeline;
    static QString codec;

    Q_PROPERTY(QString gst_pipeline NOTIFY gst_pipeline_updated)
    Q_PROPERTY(int Camera_count READ get_count NOTIFY count_changed)

    Camera();

    void get_camera_info(map<string, map<string,string>> &cameraInfo);

    // Q_INVOKABLE void update_camera_gst_pipeline(QString camera);

    Q_INVOKABLE QString get_gst_pipeline();
    Q_INVOKABLE int get_count();
    Q_INVOKABLE QString get_camera_name(int index);

    Q_INVOKABLE void update_codec(bool codec_choice);
    Q_INVOKABLE QString play_video(QString videofile);
    Q_INVOKABLE void delete_video(QString videofile);
    Q_INVOKABLE QString play_camera(QString camera);
    // Q_INVOKABLE QString record_camera(QString camera);

signals:

    void gst_pipeline_updated();
    void count_changed();
};

