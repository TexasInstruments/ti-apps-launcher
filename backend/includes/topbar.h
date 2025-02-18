#include <QObject>
#include <QString>

class power_menu : public QObject {
    Q_OBJECT

public:

    Q_INVOKABLE int button_getcount();

    Q_INVOKABLE QString button_getname(int n);

    Q_INVOKABLE QString button_getcommand(int n);

    Q_INVOKABLE QString button_geticon(int n);

};
