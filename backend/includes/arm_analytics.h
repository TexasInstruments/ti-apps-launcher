#include <QObject>
#include <QString>

#include <gst/gst.h>

class ArmAnalytics : public QObject {
    Q_OBJECT

private:
    GstElement *pipeline = NULL;

public:
    Q_INVOKABLE void startVideo(QObject* object, QString model);
    Q_INVOKABLE void stopVideo();
};
