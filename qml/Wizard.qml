import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 480
    height: 320
    title: (i18n.locale, i18n.tr("wizard.welcome"))

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: (i18n.locale, i18n.tr("wizard.welcome"))
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 16
        }
        Text {
            text: (i18n.locale, i18n.tr("wizard.intro"))
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Button {
            text: (i18n.locale, i18n.tr("wizard.next"))
            icon.source: "image://fa/arrow-right"
            onClicked: {
            }
        }

    }

}
