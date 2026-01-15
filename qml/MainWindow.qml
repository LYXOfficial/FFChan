import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.FluentWinUI3 2.15

ApplicationWindow {
    id: mainWindow

    property int lastTabIndex: 0

    // Use system frame/shadow but customize hints to remove title and close button
    flags: Qt.CustomizeWindowHint
    visible: true
    width: 640
    height: 480
    title: (i18n.locale, i18n.tr("app.title"))
    bottomPadding: 10
    leftPadding: 10
    rightPadding: 10

    ToolBar {
        width: parent.width

        MouseArea {
            anchors.fill: parent
            hoverEnabled: false
            acceptedButtons: Qt.LeftButton
            onPressed: {
                if (mouse.button === Qt.LeftButton)
                    mainWindow.startSystemMove();

            }
        }

    }

    ToolBar {
        width: parent.width

        ToolButton {
            icon.source: "image://fa/times"
            onClicked: Qt.quit()
            anchors.right: parent.right
        }

    }

    TabBar {
        id: tabBar

        anchors.top: parent.top
        anchors.left: parent.left
        currentIndex: 0
        onCurrentIndexChanged: {
            if (currentIndex === lastTabIndex)
                return ;

            stack.navDirection = (currentIndex > lastTabIndex) ? 1 : -1;
            lastTabIndex = currentIndex;
            // Use StackView animations when switching tabs
            if (currentIndex === 0)
                stack.replace(homePage);
            else if (currentIndex === 1)
                stack.replace(convertPage);
            else if (currentIndex === 2)
                stack.replace(picturesPage);
            else if (currentIndex === 3)
                stack.replace(settingsPage);
        }

        TabButton {
            text: (i18n.locale, i18n.tr("app.tab.home"))
            icon.source: "image://fa/home"
            width: implicitWidth
        }

        TabButton {
            text: (i18n.locale, i18n.tr("app.tab.convert"))
            icon.source: "image://fa/exchange"
            width: implicitWidth
        }

        TabButton {
            text: (i18n.locale, i18n.tr("app.tab.pictures"))
            icon.source: "image://fa/image"
            width: implicitWidth
        }

        TabButton {
            text: (i18n.locale, i18n.tr("app.tab.settings"))
            icon.source: "image://fa/cog"
            width: implicitWidth
        }

    }

    Frame {
        anchors.top: tabBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        StackView {
            id: stack

            property int navDirection: 1

            anchors.fill: parent
            initialItem: homePage

            replaceEnter: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 320
                    easing.type: Easing.InOutCubic
                }

                XAnimator {
                    from: 120 * stack.navDirection
                    to: 0
                    duration: 260
                    easing.type: Easing.OutQuad
                }

            }

            replaceExit: Transition {
                NumberAnimation {
                    property: "opacity"
                    from: 1
                    to: 0
                    duration: 120
                    easing.type: Easing.InOutCubic
                }

                XAnimator {
                    from: 0
                    to: -300 * stack.navDirection
                    duration: 120
                    easing.type: Easing.OutQuad
                }

            }

        }

    }

    Component {
        id: homePage

        Text {
            text: (i18n.locale, i18n.tr("app.home"))
        }

    }

    Component {
        id: convertPage

        Text {
            text: (i18n.locale, i18n.tr("app.convert"))
        }

    }

    Component {
        id: picturesPage

        Text {
            text: (i18n.locale, i18n.tr("app.pictures"))
        }

    }

    Component {
        id: settingsPage

        Text {
            text: (i18n.locale, i18n.tr("app.settings"))
        }

    }

}
