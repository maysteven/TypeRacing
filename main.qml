import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.10

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Typing Race")

    TextMetrics {
        id: textMetrics
        font.family: "Arial"
        font.pixelSize: 50
        text: textSelector.currentText
    }

    ColumnLayout{

        anchors.fill: parent
        spacing: 2
        RowLayout{
            spacing: 2
            Button{
                id: resetBtn
                icon.name: "view-refresh"
                Layout.fillWidth: true
            }
            ComboBox {
                model: texts
                id: textSelector
                Layout.fillWidth: true
            }
            Text{
                id: progress
                textFormat: Text.RichText
                Layout.fillWidth: true
            }

            Text{
                id: wpm
                textFormat: Text.RichText
                Layout.fillWidth: true
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
        }


        Rectangle{
            Layout.alignment: Qt.AlignCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                anchors.top: parent.top
                anchors.left: parent.left

                height: parent.height
                width: parent.width

                text: textMetrics.text
                font: textMetrics.font
                minimumPixelSize: 2
                fontSizeMode: Text.Fit
                wrapMode:  Text.Wrap

            }
        }
        ProgressBar{
            id:progressBar
            from:0
            to:1
            value:0
            Layout.fillWidth: true
        }

        TypingZone{
            id: typingZone
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

        }

    }

    Connections {
        target : textSelector
        onCurrentTextChanged: { controller.text = textSelector.currentText; typingZone.reset();}
    }
    Connections {
        target : typingZone
        onTextChanged: { controller.input = typingZone.text;}
    }

    Timer{
        interval: 200; running: true; repeat: true
        onTriggered:
        {
            progress.text = controller.timeElapsed+ " "+(Math.ceil(controller.progress*100.))+"%";
            wpm.text      = String(controller.wpm)+" WPM ";
        }
    }
    Connections {
        target : controller
        onProgressTextChanged: {
            typingZone.progressText      = controller.progressText;
            progressBar.value            = controller.progress;
            progressBar.background.color = controller.good ? "green":"red";
        }
    }
    Connections {
        target : resetBtn
        onClicked: {
           controller.reset();
        }
    }

}
