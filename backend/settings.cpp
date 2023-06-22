#include "includes/settings.h"
#include <iostream>

using namespace std;

void Settings::set_proxy(QString https_proxy, QString no_proxy) {
    cout << "https_proxy = " << https_proxy.toStdString() << endl;
    cout << "no_proxy = " << no_proxy.toStdString() << endl;
}

