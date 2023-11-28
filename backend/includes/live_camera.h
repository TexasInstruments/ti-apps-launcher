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


class LiveCamera : public QObject {
    Q_OBJECT

private:

    map<string, map<string,string>> cameraInfo;
    QString _camera;

    string replaceAll(string str, const string &remove, const string &insert);
    string trimString(string str);

public:

    QStringListModel LiveCamera_list;
    int LiveCamera_count;
    QString gst_pipeline;
    QString gst_pipeline_function;

    Q_PROPERTY(QString gst_pipeline READ liveCamera_gst_pipeline WRITE liveCamera_update_gst_pipeline_camera NOTIFY liveCamera_gst_pipeline_updated)
    Q_PROPERTY(QString gst_pipeline_function READ liveCamera_gst_pipeline_function WRITE liveCamera_update_gst_pipeline_function NOTIFY liveCamera_gst_pipeline_function_updated)
    Q_PROPERTY(int LiveCamera_count READ liveCamera_get_count NOTIFY liveCamera_count_changed)

    LiveCamera();

    void liveCamera_get_camera_info(map<string, map<string,string>> &cameraInfo);

    Q_INVOKABLE void liveCamera_update_gst_pipeline_camera(QString camera);
    Q_INVOKABLE void liveCamera_update_gst_pipeline_function(QString recording);

    Q_INVOKABLE QString liveCamera_gst_pipeline();
    Q_INVOKABLE QString liveCamera_gst_pipeline_function();
    Q_INVOKABLE int liveCamera_get_count();
    Q_INVOKABLE QString liveCamera_get_camera_name(int index);

signals:

    void liveCamera_gst_pipeline_updated();
    void liveCamera_gst_pipeline_function_updated();
    void liveCamera_count_changed();
};
