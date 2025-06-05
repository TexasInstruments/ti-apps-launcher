import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    width: 300
    height: 300

    property real minimumValue: 0
    property real maximumValue: 20
    property real value: 8
    property real labelStepSize: 2
    property int minorTickmarkCount: 4
    property int majorTickmarkSize: 15
    property bool showLabel: true
    property bool enlargeOrigin: false
    property real opacityValue: 1.0
    property string meterUnit: ""
    property string gaugeLabel: ""

    property string regularTickColor: "black"
    property string alertTickColor: ""
    property string regularLabelColor: "red"
    property string alertLabelColor: ""
    property string needleColor: "red"
    property string needleOriginColor: "black"

    property bool hasAlertZone: false
    property real alertPercent_start: 0
    property real alertPercent_end: 1

    property bool hasArcZone: false
    property real arcPercent_start: 0
    property real arcPercent_end: 1

    property int labelCount: ((maximumValue - minimumValue) / labelStepSize) + 1
    property real trueLabelStepSize: labelStepSize / (minorTickmarkCount + 1)
    property int totalTickmarks: (labelCount - 1) * minorTickmarkCount + labelCount

    property int initDeg: 110 /* angle (in degrees) to the 1st major tickmark */
    property int totalDeg: 320 /* total no. of degrees that all tickmarks will span */
    /* Math.trignometricFoo()'s expect angles to be in radians, whereas QML properties like "rotation:" expect them in degrees.
     * Therefore maintain angles in both.
     */
    property real intervalDeg: totalDeg / (totalTickmarks - 1) /* no. of degrees b/w 2 tickmarks */
    property real intervalRad: intervalDeg * Math.PI / 180 /* no. of radians b/w 2 major tickmarks */

    //color: "transparent"

    /* Function to be called to get the angle by which the needle must be turned
     * @returns: Angle to a label/tickmark from the X-axis
     */
    function getValueAngle(val) {
        /* "Math.min(value, maximumValue)" ensures that we don't turn the needle beyond the last label in the circle.
         * "Math.max(angle, initDeg)" ensures that we don't turn the needle to below the first label in the circle.
         */
        return Math.max((((Math.min(value, maximumValue) - minimumValue) / trueLabelStepSize) * intervalDeg + initDeg), initDeg);
    }

    Rectangle {
        id: outerCircle
        anchors.fill: parent
        color: "#f0f0f0"  /* light-grey */
        radius: width / 2
        border.color: "black"
        border.width: 3
        opacity: opacityValue
    }

    /* CircularGauge tickmarks and labels */
    Canvas {
        id: speedometerCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var centerX = width / 2
            var centerY = height / 2
            var radius = width * 0.4

            ctx.textAlign = "center"
            ctx.textBaseline = "middle"

            var alertIndex_start = Math.floor(alertPercent_start * (labelCount - 1)) * (minorTickmarkCount + 1)
            var alertIndex_end = Math.floor(alertPercent_end * (labelCount - 1)) * (minorTickmarkCount + 1)
            var arcIndex_start = Math.floor(arcPercent_start * (labelCount - 1)) * (minorTickmarkCount + 1)
            var arcIndex_end = Math.floor(arcPercent_end * (labelCount -1)) * (minorTickmarkCount + 1)

            for (var i = 0; i < totalTickmarks; i++) {
                var angle = (i * intervalRad + (initDeg * Math.PI / 180)) /* Angle (in radians) from center to the label's location */

                var tickmarkSize = (i % (minorTickmarkCount + 1)) ? majorTickmarkSize / 2 : majorTickmarkSize

                var x1 = centerX + Math.cos(angle) * radius
                var y1 = centerY + Math.sin(angle) * radius
                var x2 = centerX + Math.cos(angle) * (radius - tickmarkSize)
                var y2 = centerY + Math.sin(angle) * (radius - tickmarkSize)
                var textX = centerX + Math.cos(angle) * (radius - tickmarkSize - 15)
                var textY = centerY + Math.sin(angle) * (radius - tickmarkSize - 15)

                var styleColor
                if (hasAlertZone && i >= alertIndex_start && i <= alertIndex_end) {
                    styleColor = alertTickColor
                } else {
                    styleColor = regularTickColor
                }
                /* Draw major tickmarks */
                ctx.beginPath()
                ctx.moveTo(x1, y1)
                ctx.lineTo(x2, y2)
                ctx.strokeStyle = styleColor
                ctx.lineWidth = 2
                ctx.stroke()

                /* Draw labels */
                if (showLabel == true && !(i % (minorTickmarkCount + 1))) {
                    ctx.fillStyle = styleColor == alertTickColor ? alertLabelColor : regularLabelColor
                    ctx.fillText(i * trueLabelStepSize, textX, textY)
                }
            }

            /* create arc */
            if (hasArcZone) {
                var arcStartAngle = (arcIndex_start * intervalRad + (initDeg * Math.PI / 180))
                var arcEndAngle = (arcIndex_end * intervalRad + (initDeg * Math.PI / 180))
                ctx.beginPath()
                ctx.strokeStyle = regularTickColor
                ctx.arc(centerX, centerY, radius, arcStartAngle, arcEndAngle)
                ctx.stroke()

                /* override a portion of it with red */
                if (hasAlertZone) {
                    arcStartAngle = (alertIndex_start * intervalRad + (initDeg * Math.PI / 180))
                    arcEndAngle = (alertIndex_end * intervalRad + (initDeg * Math.PI / 180))
                    ctx.beginPath()
                    ctx.strokeStyle = alertTickColor
                    ctx.arc(centerX, centerY, radius, arcStartAngle, arcEndAngle)
                    ctx.stroke()
                }
            }
        }
    }

    /* Needle */
    Rectangle {
        width: 4
        height: parent.width * 0.35
        radius: 2
        color: needleColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter // Ensures it extends only upwards
        transformOrigin: Item.Bottom
        /* getValueAngle() returns an angle under assumption that X-Axis is horizontal and extends positively to the right.
         * But "rotation:" is behind by 90 degrees, so accomodate that */
        rotation: 90 + getValueAngle(value)
    }

    /* Needle Origin */
    Rectangle {
        id: needleOrigin
        width: enlargeOrigin ? outerCircle.width / 4 : 12
        height: enlargeOrigin ? outerCircle.height / 4 : 12
        color: needleOriginColor
        radius: enlargeOrigin ? outerCircle.radius / 4 : 6
        anchors.centerIn: parent

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 4
            visible: enlargeOrigin

            Label {
                text: Math.floor(value) < 0 ? 0 : Math.floor(value)
                font.pointSize: 28
                font.bold: true
                color: "black"
                Layout.alignment: Qt.AlignHCenter
            }

            Label {
                text: meterUnit
                font.pointSize: 10
                color: "black"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    Text {
        text: "Fuel"
        visible: gaugeLabel.length != 0
        font.pointSize: 14
        font.bold: true
        color: "white"
        anchors.top: needleOrigin.bottom
        anchors.topMargin: (outerCircle.height * 0.15)
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
