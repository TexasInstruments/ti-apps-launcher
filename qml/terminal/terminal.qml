/*
 * Copyright (C) 2021 Crimson AS <info@crimson.no>
 * Copyright (C) 2017 Robin Burchell <robin+git@viroteck.net>
 * Copyright 2011-2012 Heikki Holstila <heikki.holstila@gmail.com>
 *
 * This work is free software. you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This work is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this work.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.6
import literm 1.0
import QtQuick.Window 2.2

Rectangle {
    id: window

    width: 540
    height: 960
    color: "#000000"

    // On Mac, Ctrl == Cmd. For Linux and Windows, Alt is more natural I think.
    property string tabChangeKey: Qt.platform.os == "osx" ? "Ctrl" : "Alt"

    property int fontSize: 14*pixelRatio
    property real pixelRatio: 1.0

    Binding {
        target: window
        property: "pixelRatio"
        value: Window.window ? Window.window.devicePixelRatio : 1.0
    }

    // layout constants
    property int buttonWidthSmall: 60*pixelRatio
    property int buttonWidthLarge: 180*pixelRatio
    property int buttonWidthHalf: 90*pixelRatio

    property int buttonHeightSmall: 48*pixelRatio
    property int buttonHeightLarge: 68*pixelRatio

    property int headerHeight: 20*pixelRatio

    property int radiusSmall: 5*pixelRatio
    property int radiusMedium: 10*pixelRatio
    property int radiusLarge: 15*pixelRatio

    property int paddingSmall: 5*pixelRatio
    property int paddingMedium: 10*pixelRatio

    property int fontSizeSmall: 14*pixelRatio
    property int fontSizeLarge: 24*pixelRatio

    property int uiFontSize: Util.uiFontSize * pixelRatio

    property int scrollBarWidth: 6*window.pixelRatio

    TabView {
        id: tabView
        anchors.fill: parent

        Component.onCompleted: {
            createTab();
        }

        Component {
            id: terminalScreenComponent
            TextRender {
                id: textrender
                focus: true

                onPanLeft: {
                    Util.notifyText(Util.panLeftTitle)
                    textrender.putString(Util.panLeftCommand)
                }
                onPanRight: {
                    Util.notifyText(Util.panRightTitle)
                    textrender.putString(Util.panRightCommand)
                }
                onPanUp: {
                    Util.notifyText(Util.panUpTitle)
                    textrender.putString(Util.panUpCommand)
                }
                onPanDown: {
                    Util.notifyText(Util.panDownTitle)
                    textrender.putString(Util.panDownCommand)
                }

                onDisplayBufferChanged: {
                    textrender.cutAfter = textrender.height;
                    textrender.y = 0;
                }
                onTitleChanged: {
                    Util.windowTitle = title
                }
                dragMode: Util.dragMode
                onVisualBell: {
                    if (Util.visualBellEnabled)
                        bellTimer.start()
                }
                contentItem: Item {
                    anchors.fill: parent
                    Behavior on opacity {
                        NumberAnimation { duration: textrender.duration; easing.type: Easing.InOutQuad }
                    }
                    Behavior on y {
                        NumberAnimation { duration: textrender.duration; easing.type: Easing.InOutQuad }
                    }
                }

                ScrollDecorator {
                    anchors.right: parent.right
                    anchors.rightMargin: window.paddingMedium
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    position: ((parent.contentY) / parent.contentHeight)
                    size: (parent.visibleHeight / parent.contentHeight)
                    orientation: Qt.Vertical
                    visible: parent.contentHeight > parent.visibleHeight
                }

                cellDelegate: Rectangle {
                }
                cellContentsDelegate: Text {
                    id: text
                    property bool blinking: false

                    textFormat: Text.PlainText
                    opacity: blinking ? 0.5 : 1.0
                    SequentialAnimation {
                        running: blinking
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: text
                            property: "opacity"
                            to: 0.8
                            duration: 200
                        }
                        PauseAnimation {
                            duration: 400
                        }
                        NumberAnimation {
                            target: text
                            property: "opacity"
                            to: 0.5
                            duration: 200
                        }
                    }
                }
                cursorDelegate: Rectangle {
                    id: cursor
                    opacity: 0.5
                    SequentialAnimation {
                        running: {
                            if (Qt.application.state != Qt.ApplicationActive) {
                                return false;
                            }

                            return startPauseAnim.duration > 0 ||
                                   fadeInAnim.duration > 0 ||
                                   middlePauseAnim.duration > 0 ||
                                   fadeOutAnim.duration > 0 ||
                                   endPauseAnim.duration > 0
                        }
                        loops: Animation.Infinite
                        PauseAnimation {
                            id: startPauseAnim
                            duration: Util.cursorAnimationStartPauseDuration
                        }
                        NumberAnimation {
                            id: fadeInAnim
                            target: cursor
                            property: "opacity"
                            to: 0.8
                            duration: Util.cursorAnimationFadeInDuration
                        }
                        PauseAnimation {
                            id: middlePauseAnim
                            duration: Util.cursorAnimationMiddlePauseDuration
                        }
                        NumberAnimation {
                            id: fadeOutAnim
                            target: cursor
                            property: "opacity"
                            to: 0.5
                            duration: Util.cursorAnimationFadeOutDuration
                        }
                        PauseAnimation {
                            id: endPauseAnim
                            duration: Util.cursorAnimationEndPauseDuration
                        }
                    }
                }
                selectionDelegate: Rectangle {
                    color: "blue"
                    opacity: 0.5
                }

                Rectangle {
                    id: bellTimerRect
                    visible: opacity > 0
                    opacity: bellTimer.running ? 0.5 : 0.0
                    anchors.fill: parent
                    color: "#ffffff"
                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                }

                property int duration
                property int cutAfter: height

                anchors.fill: parent
                font.family: Util.fontFamily
                font.pointSize: Util.fontSize
                allowGestures: true

                onCutAfterChanged: {
                    // this property is used in the paint function, so make sure that the element gets
                    // painted with the updated value (might not otherwise happen because of caching)
                    textrender.redraw();
                }
            }
        }

        function createTab() {
            var tab = tabView.addTab("", terminalScreenComponent);
            tab.hangupReceived.connect(function() {
                closeTab(tab)
            });
            tabView.currentIndex = tabView.count - 1;
        }

        function closeTab(screenItem) {
            if (tabView.count == 1) {
                // Qt.quit();
                return;
            }
            for (var i = 0; i < tabView.count; i++) {
                if (tabView.getTab(i) === screenItem) {
                    tabView.removeTab(i);
                    break;
                }
            }
        }

        Shortcut {
            sequence: Qt.platform.os == "osx" ? "Ctrl+C" : "Ctrl+Shift+C"
            onActivated: {
                tabView.activeTabItem.copy();
            }
        }
        Shortcut {
            sequence: Qt.platform.os == "osx" ? "Ctrl+C" : "Ctrl+Shift+V"
            onActivated: {
                if (tabView.activeTabItem.canPaste)
                    tabView.activeTabItem.paste();
            }
        }

        // hurgh, this is a bit ugly
        Shortcut {
            sequence: window.tabChangeKey + "+1"
            onActivated: {
                if (tabView.count >= 2)
                    tabView.currentIndex = 0 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+2"
            onActivated: {
                if (tabView.count >= 2)
                    tabView.currentIndex = 1 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+3"
            onActivated: {
                if (tabView.count >= 3)
                    tabView.currentIndex = 2 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+4"
            onActivated: {
                if (tabView.count >= 4)
                    tabView.currentIndex = 3 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+5"
            onActivated: {
                if (tabView.count >= 5)
                    tabView.currentIndex = 4 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+6"
            onActivated: {
                if (tabView.count >= 6)
                    tabView.currentIndex = 5 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+7"
            onActivated: {
                if (tabView.count >= 7)
                    tabView.currentIndex = 6 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+8"
            onActivated: {
                if (tabView.count >= 8)
                    tabView.currentIndex = 7 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+9"
            onActivated: {
                if (tabView.count >= 9)
                    tabView.currentIndex = 8 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: window.tabChangeKey + "+0"
            onActivated: {
                if (tabView.count >= 10)
                    tabView.currentIndex = 9 // yes, this is right. 0 indexed.
            }
        }
        Shortcut {
            sequence: Qt.platform.os == "osx" ? "Ctrl+T" : "Ctrl+Shift+T"
            onActivated: {
                tabView.createTab();
            }
        }
        Shortcut {
            sequence: Qt.platform.os == "osx" ? "Ctrl+W" : "Ctrl+Shift+W"
            onActivated: {
                tabView.closeTab(tabView.activeTabItem)
            }
        }
        Shortcut {
            sequence: "Ctrl+Shift+]"
            onActivated: {
                tabView.currentIndex = (tabView.currentIndex + 1) % tabView.count;
            }
        }
        Shortcut {
            sequence: "Ctrl+Shift+["
            onActivated: {
                if (tabView.currentIndex > 0) {
                    tabView.currentIndex--;
                } else {
                    tabView.currentIndex = tabView.count -1;
                }
            }
        }
    }

    Timer {
        id: bellTimer

        interval: 80
    }

    Connections {
        target: Util
        onNotify: {
            textNotify.text = msg;
            textNotifyAnim.enabled = false;
            textNotify.opacity = 1.0;
            textNotifyAnim.enabled = true;
            textNotify.opacity = 0;
        }
    }

    Rectangle {
        // visual key press feedback...
        // easier to work with the coordinates if it's here and not under keyboard element
        id: visualKeyFeedbackRect

        property string label

        visible: false
        radius: window.radiusSmall
        color: "#ffffff"

        Text {
            color: "#000000"
            font.pointSize: 34*window.pixelRatio
            anchors.centerIn: parent
            text: visualKeyFeedbackRect.label
        }
    }

    Component.onCompleted: {
	tabView.fixupVisibility();
    }
}
