#include <unordered_map>
#include <QString>
#include <QObject>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QProcess>

using namespace std;
extern unordered_map<string, string> proxy_list;

class Settings : public QObject {
    Q_OBJECT

public:
    QString _https_proxy;
    QString _no_proxy;
    Q_INVOKABLE void set_proxy(QString https_proxy, QString no_proxy);

};

