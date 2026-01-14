import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 320
    height: 320
    title: ""

    Column {
        anchors.centerIn: parent
        spacing: 12

        // App icon centered at the top of the wizard
        Image {
            source: "qrc:/icon.png"
            width: 96
            height: 96
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: (i18n.locale, i18n.tr("wizard.welcome"))
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 16
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: (i18n.locale, i18n.tr("wizard.intro"))
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            width: parent.width * 0.9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Button {
            text: (i18n.locale, i18n.tr("wizard.next"))
            icon.source: "image://fa/arrow-right"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
            }
        }

    }

}
