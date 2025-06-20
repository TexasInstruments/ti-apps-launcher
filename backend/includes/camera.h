#include <QObject>
#include <QStringListModel>
#include <QString>
#include <QQuickItem>

#include <map>
#include <string>
#include <gst/gst.h>

class Camera : public QObject {
    Q_OBJECT

private:

    std::map<std::string, std::map<std::string,std::string>> cameraInfo;
    QString _videofile;
    GstElement *pipeline;

    std::string replaceAll(std::string str, const std::string &remove, const std::string &insert);
    std::string trimString(std::string str);

public:

    QStringListModel Camera_list;
    int Camera_count;
    QString gst_pipeline;
    static QString codec;
    QString filename;
    QString _camera;

    Q_PROPERTY(QString gst_pipeline NOTIFY gst_pipeline_updated)
    Q_PROPERTY(QString filename READ get_filename NOTIFY filename_changed)
    Q_PROPERTY(QString _camera READ get_current_camera NOTIFY current_camera_changed)
    Q_PROPERTY(int Camera_count READ get_count NOTIFY count_changed)

    void get_camera_info(std::map<std::string, std::map<std::string,std::string>> &cameraInfo);

    Q_INVOKABLE QString get_gst_pipeline();
    Q_INVOKABLE int get_count();
    Q_INVOKABLE QString get_filename();
    Q_INVOKABLE QString get_camera_name(int index);
    Q_INVOKABLE QString get_current_camera();

    Q_INVOKABLE void update_codec(bool codec_choice);
    Q_INVOKABLE QString play_video(QString videofile);
    Q_INVOKABLE void delete_video(QString videofile);
    Q_INVOKABLE QString play_camera(QString camera);
    Q_INVOKABLE QString record_camera(QString camera);

    Q_INVOKABLE void stopStream();
    Q_INVOKABLE void startStream(QObject *object);

    static gboolean busCall(GstBus *bus, GstMessage *msg, gpointer data);

signals:

    void gst_pipeline_updated();
    void count_changed();
    void filename_changed();
    void current_camera_changed();
    void videoPlayFinished();
};

