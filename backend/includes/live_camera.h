#include <map>
#include <string>

#include <QObject>
#include <QStringListModel>
#include <QString>
#include <gst/gst.h>

class LiveCamera : public QObject {
    Q_OBJECT

private:

    std::map<std::string, std::map<std::string,std::string>> cameraInfo;
    QString _camera;

    std::string replaceAll(std::string str, const std::string &remove, const std::string &insert);
    std::string trimString(std::string str);

    GstElement *pipeline = NULL;

public:

    QStringListModel LiveCamera_list;
    int LiveCamera_count;
    QString gst_pipeline;

    Q_PROPERTY(QString gst_pipeline READ liveCamera_gst_pipeline WRITE liveCamera_update_gst_pipeline NOTIFY liveCamera_gst_pipeline_updated)
    Q_PROPERTY(int LiveCamera_count READ liveCamera_get_count NOTIFY liveCamera_count_changed)

    void liveCamera_get_camera_info(std::map<std::string, std::map<std::string,std::string>> &cameraInfo);

    Q_INVOKABLE void liveCamera_update_gst_pipeline(QString camera);

    Q_INVOKABLE QString liveCamera_gst_pipeline();
    Q_INVOKABLE int liveCamera_get_count();
    Q_INVOKABLE QString liveCamera_get_camera_name(int index);
    Q_INVOKABLE void stopStream();
    Q_INVOKABLE void startStream(QObject *object);

signals:

    void liveCamera_gst_pipeline_updated();
    void liveCamera_count_changed();
};
