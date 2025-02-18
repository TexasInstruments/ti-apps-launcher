#include <QObject>
#include <QString>

class stats : public QObject {
    Q_OBJECT

private:

public:

    Q_INVOKABLE QString getgpuload();
    Q_INVOKABLE QString getcpuload();
    Q_INVOKABLE QString get_soc_temp();
    Q_INVOKABLE unsigned int getddrload();
    Q_INVOKABLE unsigned int getddrtotalbw();
    Q_INVOKABLE unsigned int getddrreadbw();
    Q_INVOKABLE unsigned int getddrwritebw();
};
