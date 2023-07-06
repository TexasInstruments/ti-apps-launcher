import QtQml 2.1
import QtQuick 2.14
import QtMultimedia 5.1
import QtQuick.Window 2.14
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.12
import Qt.labs.folderlistmodel 2.4

import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
Window {
    visible: true
    visibility: "FullScreen"
    title: qsTr("TI Apps Launcher")

    Rectangle {
        id: appBackground
        color: "#17252A"
        width: parent.width
        height: parent.height

        // Section1: TopBar
        // This contains Texas Instruments Logo, application title
        Rectangle {
            id: topBarRect
            width: parent.width
            height: parent.height * 0.1
            anchors.top: parent.top
            anchors.left: parent.left
            border.color: "#CCCCCC"
            border.width: 2
            Loader {
                id: topBar
                anchors.fill: parent
                source: "apps/topbar.qml"
            }
        }

        // Section2: AppsMenu
        // This displays the buttons to launch applications
        Rectangle {
            id: appsMenuRect
            width: parent.width * 0.15
            height: parent.height * 0.70
            anchors.top: topBarRect.bottom
            anchors.left: parent.left
            border.color: "#CCCCCC"
            border.width: 2
            Loader {
                id: appsMenu
                anchors.fill: parent
                source: "apps/appsmenu.qml"
            }
        }

        // Section3: AppWindow
        // This displays the currently running application
        Rectangle {
            id: appWindowRect
            width: parent.width * 0.835
            height: parent.height * 0.70
            anchors.top: topBarRect.bottom
            anchors.left: appsMenuRect.right
            anchors.rightMargin: parent.width * 0.015
            border.color: "#CCCCCC"
            border.width: 2
            /*
            Image {
                id: mainimg
                visible: true
                width: parent.width
                height: parent.height
                source: "file://home/root/jacinto_oob_demo_home_image.png"
                anchors.fill: parent
                anchors.margins: parent.border.width * 2
            }
            */
            Loader {
                id: appWindow
                anchors.fill: parent
                anchors.topMargin: 5
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
            }
        }

        // Section4: DeviceInfo
        // This section displays device info
        Rectangle {
            id: deviceInfoRect
            anchors.horizontalCenter: appsMenuRect.horizontalCenter
            anchors.top: appsMenuRect.bottom
            height: parent.height * 0.15
            width: parent.width * 0.15
            border.color: "#CCCCCC"
            border.width: 2
            anchors.topMargin: parent.height * 0.025
            anchors.bottomMargin: parent.height * 0.025
            Loader {
                id: deviceInfo
                anchors.fill: parent
                source: "apps/deviceinfo.qml"
            }
        }

        // Section5: StatsWindow
        // This section displays device load statistics
        Rectangle {
            id: statsWindowRect
            width: appWindowRect.width
            height: parent.height * 0.15
            anchors.horizontalCenter: appWindowRect.horizontalCenter
            anchors.top: appWindowRect.bottom
            border.color: "#CCCCCC"
            border.width: 2
            anchors.topMargin: parent.height * 0.025
            anchors.bottomMargin: parent.height * 0.025
            Loader {
                id: statsWindow
                anchors.fill: parent
                anchors.topMargin: 5
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                source: "apps/stats.qml"
            }
        }
    }
}
