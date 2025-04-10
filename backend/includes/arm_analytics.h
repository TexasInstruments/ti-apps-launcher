#include <QObject>
#include <QString>

#include <gst/gst.h>

class ArmAnalytics : public QObject {
    Q_OBJECT

private:
    GstElement *pipeline = NULL;
    QString currentModel = "";
    void startVideo(QObject* object);
    void stopVideo();

public:
    Q_INVOKABLE void changePipeline(QObject *object, QString model);
};
