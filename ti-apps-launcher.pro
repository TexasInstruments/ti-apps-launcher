QT = core gui qml quick multimedia

CONFIG -= app_bundle

MOC_DIR = .moc
OBJECTS_DIR = .obj

CONFIG += link_pkgconfig

TEMPLATE = app
TARGET = ti-apps-launcher
DEPENDPATH += .
INCLUDEPATH += .
LIBS += -lutil

# Input
HEADERS += \
    include/terminal/ptyiface.h \
    include/terminal.h \
    include/terminal/textrender.h \
    include/terminal/version.h \
    include/terminal/utilities.h \
    include/terminal/keyloader.h \
    include/terminal/parser.h \
    include/terminal/catch.hpp \
    include/appsmenu.h \
    include/arm_analytics.h \
    include/benchmarks.h \
    include/camera.h \
    include/common.h \
    include/deviceinfo.h \
    include/gpu_performance.h \
    include/live_camera.h \
    include/run_cmd.h \
    include/settings.h \
    include/stats.h \
    include/topbar.h \
    include/perf_stats.h

SOURCES += \
    backend/ti-apps-launcher.cpp \
    backend/terminal.cpp \
    backend/terminal/textrender.cpp \
    backend/terminal/ptyiface.cpp \
    backend/terminal/utilities.cpp \
    backend/terminal/keyloader.cpp \
    backend/terminal/parser.cpp \
    backend/appsmenu.cpp \
    backend/arm_analytics.cpp \
    backend/benchmarks.cpp \
    backend/camera.cpp \
    backend/deviceinfo.cpp \
    backend/gpu_performance.cpp \
    backend/live_camera.cpp \
    backend/run_cmd.cpp \
    backend/settings.cpp \
    backend/stats.cpp \
    backend/topbar.cpp \
    backend/perf_stats.cpp

OTHER_FILES += \
    qml/desktop/Main.qml \
    qml/desktop/Keyboard.qml \
    qml/desktop/Key.qml \
    qml/desktop/Button.qml \
    qml/desktop/MenuLiterm.qml \
    qml/desktop/NotifyWin.qml \
    qml/desktop/UrlWindow.qml \
    qml/desktop/LayoutWindow.qml \
    qml/desktop/PopupWindow.qml \
    qml/desktop/TabView.qml \
    qml/desktop/TabBar.qml

RESOURCES += \
    ti-apps-launcher.qrc

target.path = /usr/bin
INSTALLS += target

