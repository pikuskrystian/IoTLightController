import QtQuick 2.15
import QtQml 2.2

Item {
    id: root
    width: 575
    height: 450
    property bool bulbswitch: false

    property var bulbs : [
        { on: false, x:  50, y: 25 },
        { on: false, x:  40, y: 95 },
        { on: false, x: 125, y: 60 },
        { on: false, x: 105, y: 140 },
        { on: false, x:  75, y: 200 },
        { on: false, x:  38, y: 310 },
        { on: false, x: 100, y: 280 },
        { on: false, x: 160, y: 295 },
        { on: false, x: 420, y: 35 },
        { on: false, x: 270, y: 70 },
        { on: false, x: 275, y: 165 },
        { on: false, x: 240, y: 330 },
        { on: false, x: 320, y: 340 },
        { on: false, x: 435, y: 320 },
        { on: false, x: 390, y: 380 },
        { on: false, x: 475, y: 380 },
    ];

    MouseArea {
        anchors.fill: parent

        onClicked: {
            // console.log("Mouse", mouseX, mouseY);
            for (var i = 0; i < bulbs.length; i++) {
                if(getDistance(mouseX, mouseY, bulbs[i].x, bulbs[i].y)<32) {
                    bulbs[i].on = !bulbs[i].on
                    canvas.requestPaint()
                    bulbswitch=!bulbswitch
                }
            }
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        onImageLoaded: requestPaint()

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.beginPath()

            ctx.drawImage("picture/house.png", 0, 0)
            for (var i = 0; i < bulbs.length; i++) {
                ctx.drawImage(bulbs[i].on  ? "picture/bulbOn.png" : "picture/bulbOff.png",  bulbs[i].x,  bulbs[i].y)
            }
        }
    }

    function lightSwitch(bulb, state) {

        bulbs[bulb].on=state
        canvas.requestPaint()
    }

    function getDistance(mx, my, px, py){
        px+=32
        py+=32
        return (Math.sqrt((mx-px)*(mx-px)+(my-py)*(my-py)))
    }

    function bulbState(bulb) {
        return bulbs[bulb].on
    }
}
