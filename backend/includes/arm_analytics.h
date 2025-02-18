#include <QObject>
#include <QString>

class ArmAnalytics : public QObject {
    Q_OBJECT

private:

    QString _model;

public:

    QString gst_pipeline;

    Q_PROPERTY(QString gst_pipeline READ armAnalytics_gst_pipeline WRITE armAnalytics_update_gst_pipeline NOTIFY armAnalytics_gst_pipeline_updated)

    Q_INVOKABLE void armAnalytics_update_gst_pipeline(QString model);

    Q_INVOKABLE QString armAnalytics_gst_pipeline();

signals:

    void armAnalytics_gst_pipeline_updated();
};

