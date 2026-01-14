import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: qsTr("Qt Quick QML C++ CMake Demo")

    Column {
        anchors.centerIn: parent
        spacing: 10

        Text {
            id: label
            text: backend.message
            font.pointSize: 16
            horizontalAlignment: Text.AlignHCenter
        }

        Button {
            text: "Change from QML"
            onClicked: backend.setMessage("Changed from QML at " + Date().toLocaleTimeString())
        }
    }
}
