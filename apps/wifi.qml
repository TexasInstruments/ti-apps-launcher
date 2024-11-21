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

Rectangle {
    width: parent.width
    height: parent.height
    color: "#344045"

    // toggle switch
    Rectangle {
        id: toggle
        width: parent.width * 0.3
        height: parent.height * 0.5
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#344045"

        Switch {
                id: networktoggle
                checked: false
                height: parent.height * 0.06
                width: parent.width * 0.2
                anchors.top: parent.top
                anchors.topMargin: 1
                anchors.horizontalCenter: parent.horizontalCenter
                indicator: Rectangle {
                    implicitWidth: parent.width
                    implicitHeight: parent.height
                    x: networktoggle.leftPadding
                    y: parent.height - height / 2
                    radius: implicitHeight / 2
                    color: wifi.wifiOn ? "#566673" : "#ffffff"
                    border.color: wifi.wifiOn ? "#ffffff" : "#D0D3D4"

                Rectangle {
                    x: wifi.wifiOn ? parent.width - width : 0
                    implicitHeight: parent.height * 1.2
                    width: height
                    anchors.verticalCenter: parent.verticalCenter
                    radius: implicitHeight
                    color: "#1B2631"
                    border.color: wifi.wifiOn ? "#D0D3D4" : "#ffffff"
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width
                    leftPadding: 10
                    rightPadding: 10
                    text: wifi.wifiOn ? "ON" : "OFF"
                    font.pixelSize: parent.height * 0.8
                    horizontalAlignment: wifi.wifiOn ? Text.AlignLeft : Text.AlignRight
                    color: wifi.wifiOn ? "#ffffff" : "#1B2631"
                }
            }
            onClicked: {
                wifi.toggle()
                if (!wifi.wifiOn && !wifi.previousWifiOn) {
                    wifiErrorMessage.visible = true
                } else {
                    wifiErrorMessage.visible = false
                    connection_status.text = ""
                }
            }
        }
    }

    // SSID Section in the center
    Rectangle {
        id: ssidSection
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: parent.width * 0.4
        height: parent.height * 0.5
        y: (parent.height - height) / 2

        ColumnLayout {
            anchors.fill: ssidSection
            anchors.centerIn: ssidSection
            spacing: 10

            Rectangle {
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                visible: wifi.wifiOn && !wifi.wifiConnected
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height * 0.2

                // Connect to SSID head
                Text {
                    id: ssidConnectForm
                    text: "Connect to Wifi"
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    font.pixelSize: ssidSection.width * 0.05
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }

                // Chosse SSID section
                Text{
                    id: ssidHead
                    anchors.top: ssidConnectForm.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    height: 30
                    width: parent.width * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: parent.width * 0.05
                    text: "Choose SSID:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                ComboBox {
                    id: ssidnames
                    anchors.top: ssidHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: ssidHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    model: wifi.ssidList
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                    font.pixelSize: ssidSection.width * 0.03
                }
                Button {
                    id: refreshButton
                    text: "Refresh"
                    anchors.top: ssidnames.top
                    //anchors.topMargin: parent.height * 0.05
                    anchors.left: ssidnames.right
                    anchors.leftMargin: 10
                    Layout.preferredWidth: parent.width * 0.5
                    height: 30
                    font.pixelSize: ssidSection.width * 0.04
                    font.family: "Helvetica"
                    onClicked: wifi.fetchSSIDNames()
                    background: Rectangle {
                        color: refreshButton.pressed ? "#add8e6" : "#ffffff"
                        radius: parent.width / 2
                    }
                }

                // Choose security type
                Text{
                    id: securityTypeHead
                    anchors.top: ssidHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    height: 30
                    width: parent.width * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: parent.width * 0.05
                    text: "Choose Security Type:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                ComboBox {
                    id: securityType
                    anchors.top: securityTypeHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: securityTypeHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    model: ["NONE", "WPA-PSK", "SAE", "WPA-EAP", "WPA-EAP-SHA256"]
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                    font.pixelSize: ssidSection.width * 0.03
                }

                // Choose PMF
                Text{
                    id: pmfHead
                    anchors.top: securityTypeHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    height: 30
                    width: parent.width * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: parent.width * 0.05
                    text: "PMF:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                ComboBox {
                    id: pmf
                    anchors.top: pmfHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: pmfHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    model: ["0", "1", "2"]
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                    font.pixelSize: ssidSection.width * 0.03
                }

                // Write Identity
                Text{
                    id: identityHead
                    anchors.top: pmfHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    height: 30
                    width: parent.width * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: parent.width * 0.05
                    text: "Identity:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                TextField {
                    id: identity
                    anchors.top: identityHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: identityHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    placeholderText: "for WPA-EAP/WPA-EAP-SHA256"
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                    font.pixelSize: ssidSection.width * 0.03
                }

                // Write client certificate file path
                Text{
                    id: clientCertHead
                    anchors.top: identityHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    anchors.left: parent.left
                    height: 30
                    width: parent.width * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: parent.width * 0.05
                    text: "Client Cert. File Path:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                TextField {
                    id: clientCert
                    anchors.top: clientCertHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: clientCertHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    placeholderText: "for WPA-EAP/WPA-EAP-SHA256"
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                    font.pixelSize: ssidSection.width * 0.03
                }

                // Write private key cert file path
                Text {
                    id: privateKeyHead
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: clientCertHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    text: "Private Key Cert. Path:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                    height: 30
                    width: parent.width * 0.1
                }
                TextField {
                    id: privateKey
                    anchors.top: privateKeyHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: privateKeyHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    font.pixelSize: ssidSection.width * 0.03
                    placeholderText: "for WPA-EAP/WPA-EAP-SHA256"
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                }

                // Write private key password
                Text {
                    id: privateKeyPasswordHead
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: privateKeyHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    text: "Private Key Password:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                    height: 30
                    width: parent.width * 0.1
                }
                TextField {
                    id: privateKeyPassword
                    anchors.top: privateKeyPasswordHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: privateKeyPasswordHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    font.pixelSize: ssidSection.width * 0.03
                    placeholderText: "for WPA-EAP/WPA-EAP-SHA256"
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                }

                // Write password
                Text {
                    id: passwordHead
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.top: privateKeyPasswordHead.bottom
                    anchors.topMargin: parent.height * 0.1
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    text: "Password:"
                    font.pixelSize: ssidSection.width * 0.04
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                    height: 30
                    width: parent.width * 0.1
                }
                TextField {
                    id: passwordText
                    anchors.top: passwordHead.top
                    anchors.topMargin: parent.height * 0.05
                    anchors.left: passwordHead.right
                    anchors.leftMargin: 10
                    height: 30
                    width: parent.width * 0.7
                    font.pixelSize: ssidSection.width * 0.03
                    placeholderText: "Enter Password"
                    background: Rectangle {
                        radius: parent.width * 0.1
                    }
                }

                // Connect button
                Button {
                    id: connectButton
                    text: "Connect"
                    anchors.top: passwordText.bottom
                    anchors.topMargin: parent.height * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredWidth: parent.width * 0.5
                    height: 30
                    font.pixelSize: ssidSection.width * 0.04
                    font.family: "Helvetica"
                    background: Rectangle {
                        color: connectButton.pressed ? "#add8e6" : "#ffffff"
                        radius: parent.height / 2
                    }
                    onClicked: {
                        wifi.connect(ssidnames.currentText, securityType.currentText, pmf.currentText,
                            identity.text, clientCert.text, privateKey.text, privateKeyPassword.text,
                            passwordText.text)
                        if (!wifi.wifiConnected) {
                            connection_status.text = "Connection Failed!"
                            connection_status.color = "#FF0000"
                        }
                    }
                }
                Text {
                    id: connection_status
                    Layout.alignment: Qt.AlignCenter
                    anchors.top: connectButton.bottom
                    anchors.topMargin: parent.height * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""
                    font.pixelSize: ssidSection.width * 0.03
                    font.family: "Helvetica"
                    color: "#FF0000"
                }
            }

            Rectangle {
                id: wifiErrorMessage
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height * 0.2
                visible: false
                Text {
                    text: "Failed to turn on Wi-Fi!!!"
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    font.pixelSize: ssidSection.width * 0.05
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
            }
        }
    }

    // connected to SSID
    Rectangle {
        id: connectedSsidSection
        color: "transparent"
        visible: wifi.wifiOn && wifi.wifiConnected
        anchors.centerIn: parent
        width: parent.width * 0.4
        height: parent.height * 0.4

        ColumnLayout {
            anchors.fill: connectedSsidSection
            anchors.centerIn: connectedSsidSection
            spacing: 10
            Rectangle {
                color: "transparent"
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: parent.height * 0.2
                Text {
                    id: ssidConnected
                    text: "Connected to SSID: " + wifi.ssid
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    font.pixelSize: connectedSsidSection.width * 0.05
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.family: "Helvetica"
                    color: "#FEFEFE"
                }
                Button {
                    id: disconnectButton
                    text: "Disconnect"
                    anchors.top: ssidConnected.bottom
                    anchors.topMargin: parent.height * 0.3
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredWidth: parent.width * 0.5
                    Layout.preferredHeight: parent.height * 0.15
                    font.pixelSize: connectedSsidSection.width * 0.04
                    font.family: "Helvetica"
                    background: Rectangle {
                        color: disconnectButton.pressed ? "#add8e6" : "#ffffff"
                        radius: parent.height / 2
                    }
                    onClicked: {
                        wifi.disconnect()
                        connection_status.text = "Disconnected successfully!"
                        connection_status.color = "#00FF00"
                    }
                }
            }
        }
    }
}
