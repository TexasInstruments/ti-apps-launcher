import QtQuick
import QtQuick.Controls

Item {
    width: 300
    height: 300

    property real minimumValue: 0
    property real maximumValue: 20
    property real value: 8
    property real labelStepSize: 2
    property int minorTickmarkCount: 4

    property int labelCount: ((maximumValue - minimumValue) / labelStepSize) + 1

    property int initDeg: 110 /* angle (in degrees) to the 1st major tickmark */
    property int totalDeg: 320 /* total no. of degrees that all tickmarks will span */
    /* Math.trignometricFoo()'s expect angles to be in radians, whereas QML properties like "rotation:" expect them in degrees.
     * Therefore maintain angles in both.
     */
    property real intervalDeg: totalDeg / (labelCount - 1) /* no. of degrees b/w 2 major tickmarks */
    property real intervalRad: intervalDeg * Math.PI / 180 /* no. of radians b/w 2 major tickmarks */

    /* Function to be called to get the angle by which the needle must be turned
     * @returns: Angle to a label/tickmark from the X-axis
     */
    function getValueAngle(val) {
        /* "Math.min(value, maximumValue)" ensures that we don't turn the needle beyond the last label in the circle.
         * "Math.max(angle, initDeg)" ensures that we don't turn the needle to below the first label in the circle.
         */
        return Math.max((((Math.min(value, maximumValue) - minimumValue) / labelStepSize) * intervalDeg + initDeg), initDeg);
    }

    Rectangle {
        anchors.fill: parent
        color: "#f0f0f0"  /* light-grey */
        radius: width / 2
        border.color: "black"
        border.width: 3
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

            for (var i = 0; i < labelCount; i++) {
                var angle = (i * intervalRad + (initDeg * Math.PI / 180)) /* Angle (in radians) from center to the label's location */

                var x1 = centerX + Math.cos(angle) * radius
                var y1 = centerY + Math.sin(angle) * radius
                var x2 = centerX + Math.cos(angle) * (radius - 15)
                var y2 = centerY + Math.sin(angle) * (radius - 15)
                var textX = centerX + Math.cos(angle) * (radius - 30)
                var textY = centerY + Math.sin(angle) * (radius - 30)

                /* Draw major tickmarks */
                ctx.beginPath()
                ctx.moveTo(x1, y1)
                ctx.lineTo(x2, y2)
                ctx.strokeStyle = "black"
                ctx.lineWidth = 2
                ctx.stroke()

                /* Draw labels */
                ctx.fillStyle = "red"
                ctx.fillText(i * labelStepSize, textX, textY)

                /* Draw minor tickmarks */
                for (var j = 1; j <= minorTickmarkCount; ++j) {
                    if (i == labelCount - 1) {
                        break
                    }
                    var minorAngle = ((j * intervalRad / (minorTickmarkCount + 1)) + angle)
                    var mx1 = centerX + Math.cos(minorAngle) * radius
                    var my1 = centerY + Math.sin(minorAngle) * radius
                    var mx2 = centerX + Math.cos(minorAngle) * (radius - 7)
                    var my2 = centerY + Math.sin(minorAngle) * (radius - 7)
                    ctx.beginPath()
                    ctx.moveTo(mx1, my1)
                    ctx.lineTo(mx2, my2)
                    ctx.strokeStyle = "black"
                    ctx.lineWidth = 2
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
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter // Ensures it extends only upwards
        transformOrigin: Item.Bottom
        /* getValueAngle() returns an angle under assumption that X-Axis is horizontal and extends positively to the right.
         * But "rotation:" is behind by 90 degrees, so accomodate that */
        rotation: 90 + getValueAngle(value)
    }

    /* Needle Origin */
    Rectangle {
        width: 12
        height: 12
        color: "black"
        radius: 6
        anchors.centerIn: parent
    }
}
