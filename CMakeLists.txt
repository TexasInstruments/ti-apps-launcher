cmake_minimum_required(VERSION 3.16)
project(ti-apps-launcher VERSION 1.0 LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
include(GNUInstallDirs)

find_package(QT NAMES Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Widgets Multimedia Quick)

find_package(PkgConfig REQUIRED)
pkg_search_module(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0>=1.22)

set(SOURCES
    ti-apps-launcher.cpp
    backend/appsmenu.cpp backend/includes/appsmenu.h
    backend/arm_analytics.cpp backend/includes/arm_analytics.h
    backend/benchmarks.cpp backend/includes/benchmarks.h
    backend/camera.cpp backend/includes/camera.h
    backend/deviceinfo.cpp backend/includes/deviceinfo.h
    backend/gpu_performance.cpp backend/includes/gpu_performance.h
    backend/live_camera.cpp backend/includes/live_camera.h
    backend/run_cmd.cpp backend/includes/run_cmd.h
    backend/settings.cpp backend/includes/settings.h
    backend/stats.cpp backend/includes/stats.h
    backend/topbar.cpp backend/includes/topbar.h
    backend/wifi.cpp backend/includes/wifi.h
    utils/perf_stats.cpp
    configs/platform.cpp
)

qt_add_resources(RESOURCES
    ti-apps-launcher.qrc
)

add_executable(ti-apps-launcher
    ${SOURCES}
    ${RESOURCES}
)
target_link_libraries(ti-apps-launcher PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Widgets
    Qt::Multimedia
    Qt::Quick
    PkgConfig::gstreamer
)

install(TARGETS ti-apps-launcher
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
