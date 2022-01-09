import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 450
    visible: true
    title: qsTr("Light Controller")
    property bool ready: false

    Frame {
        id: frameText
        height: 30
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        Text {
            id: textInfo
            anchors.centerIn: parent
            color: "#ffffff"
            text: qsTr("Device ID:")
            font.pixelSize: 15
        }
    }

    Frame {
        id: frameButtons1
        anchors.top: frameText.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 110

        Column {
            id: column1
            anchors.centerIn: parent
            //spacing: 5

            Repeater{
                id: repeater1
                model: ["Out 1", "Out 2", "Out 3", "Out 4", "Out 5", "Out 6", "Out 7", "Out 8"]

                Switch{
                    text: modelData

                    onCheckedChanged: {
                        scene1.lightSwitch(index, checked)
                        if(root.ready)
                            appcore.onSendValue(index, checked)
                    }
                }
            }
        }
    }

    Frame {
        id: frameButtons2
        anchors.top: frameText.bottom
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 110

        Column {
            id: column2
            anchors.centerIn: parent

            Repeater{
                id: repeater2
                model: ["Out 9", "Out 10", "Out 11", "Out 12", "Out 13", "Out 14", "Out 15", "Out 16"]

                Switch{
                    text: modelData

                    onCheckedChanged: {
                        scene1.lightSwitch(index+8, checked)
                        if(root.ready)
                            appcore.onSendValue(index+8, checked)
                    }
                }
            }
        }
    }

    Frame {
        id: framePicture
        anchors.top: frameText.bottom
        anchors.topMargin: 10
        anchors.left: frameButtons1.right
        anchors.leftMargin: 10
        anchors.right: frameButtons2.left
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        Scene {
            id: scene1
            anchors.centerIn: parent
            scale: framePicture.width/600


            onBulbswitchChanged: {

                for (var i = 0; i < repeater1.model.length; i++) {
                    repeater1.itemAt(i).checked = bulbState(i)
                }
                for (i = 0; i < repeater2.model.length; i++) {
                    repeater2.itemAt(i).checked = bulbState(i+8)
                }
            }
        }
    }

    Connections {
        target: appcore
        function onIsDataChanged() {

            for (var i = 0; i < repeater1.model.length; i++) {
                repeater1.itemAt(i).checked = appcore.getValue(i)
            }
            for (i = 0; i < repeater2.model.length; i++) {
                repeater2.itemAt(i).checked = appcore.getValue(i+8)
            }
            root.ready=true;
            textInfo.text=appcore.getInfo();
            //console.log("DataChanged", getValue(0));
        }
    }
}
