import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

ApplicationWindow {
    // Fixed-size, non-maximizable wizard window
    flags: Qt.Window
    visible: true
    width: 320
    height: 280
    minimumWidth: width
    maximumWidth: width
    minimumHeight: height
    maximumHeight: height
    title: " "
    Column {
        topPadding: 24
        spacing: 12
        Image {
            source: "qrc:/icon.png"
            width: 96
            height: 96
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle {
            height: 1
            width: 250
            color: "#d0d0d0"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        StackView {
            id: stack
            width: 320
            height: 120
            initialItem: welcomePage
        }
    }

    Component {
        id: welcomePage
        Page {
            Column {
                anchors.centerIn: parent
                spacing: 12
                Label {
                    text: (i18n.locale, i18n.tr("wizard.welcome"))
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Label {
                    text: (i18n.locale, i18n.tr("wizard.intro"))
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Button {
                    text: (i18n.locale, i18n.tr("wizard.next"))
                    icon.source: "image://fa/arrow-right"
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: stack.push(languagePage)
                }
            }
        }
    }

    Component {
        id: languagePage
        Page {
            Column {
                anchors.centerIn: parent
                spacing: 6

                Label {
                    text: (i18n.locale, i18n.tr("wizard.language"))
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox {
                    model: {
                        let arr = [];
                        for (let i = 0; i < i18n.availableLocales.length; i++) {
                            arr.push(i18n.availableLocales[i]);
                        }
                        return arr.map(locale => `${(i18n.locale, i18n.tr("language." + locale))} (${locale})`);
                    }
                    currentValue: `${(i18n.locale, i18n.tr("language." + i18n.locale))} (${i18n.locale})`
                    onCurrentIndexChanged: () => {
                        i18n.setLocale(i18n.availableLocales[currentIndex]);
                        settings.set("language", i18n.availableLocales[currentIndex]);
                    }
                    width: 180
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 12
                    Button {
                        text: (i18n.locale, i18n.tr("wizard.back"))
                        onClicked: stack.pop()
                        icon.source: "image://fa/arrow-left"
                    }
                    Button {
                        text: (i18n.locale, i18n.tr("wizard.next"))
                        // onClicked: stack.push(themePage)
                        onClicked: stack.push(scanPage)
                        icon.source: "image://fa/arrow-right"
                    }
                }
            }
        }
    }
    // Component {
    //     id: themePage
    //     Page {
    //         Column {
    //             anchors.centerIn: parent
    //             spacing: 6

    //             Label {
    //                 text: (i18n.locale, i18n.tr("wizard.theme"))
    //                 horizontalAlignment: Text.AlignHCenter
    //                 font.pointSize: 14
    //                 anchors.horizontalCenter: parent.horizontalCenter
    //             }
    //             GroupBox {
    //                 title: (i18n.locale, i18n.tr("wizard.theme.mode"))
    //                 anchors.horizontalCenter: parent.horizontalCenter
    //                 Row {
    //                     anchors.horizontalCenter: parent.horizontalCenter
    //                     spacing: 12
    //                     Button {
    //                         text: (i18n.locale, i18n.tr("wizard.theme.mode.light"))
    //                         flat: theme.mode !== "light"
    //                         onClicked: () => {
    //                             settings.set("theme/mode", "light");
    //                             theme.setMode("light");
    //                         }
    //                         icon.source: "image://fa/sun"
    //                     }
    //                     Button {
    //                         text: (i18n.locale, i18n.tr("wizard.theme.mode.dark"))
    //                         flat: theme.mode !== "dark"
    //                         onClicked: () => {
    //                             settings.set("theme/mode", "dark");
    //                             theme.setMode("dark");
    //                         }
    //                         icon.source: "image://fa/moon"
    //                     }
    //                     Button {
    //                         text: (i18n.locale, i18n.tr("wizard.theme.mode.auto"))
    //                         flat: theme.mode !== "auto"
    //                         onClicked: () => {
    //                             settings.set("theme/mode", "auto");
    //                             theme.setMode("auto");
    //                         }
    //                         icon.source: "image://fa/adjust"
    //                     }
    //                 }
    //             }
    //             Row {
    //                 anchors.horizontalCenter: parent.horizontalCenter
    //                 spacing: 12
    //                 Button {
    //                     text: (i18n.locale, i18n.tr("wizard.back"))
    //                     onClicked: stack.pop()
    //                     icon.source: "image://fa/arrow-left"
    //                 }
    //                 Button {
    //                     text: (i18n.locale, i18n.tr("wizard.next"))
    //                     onClicked: stack.push(themePage)
    //                     icon.source: "image://fa/arrow-right"
    //                 }
    //             }
    //         }
    //     }
    // }
    Component {
        id: scanPage
        Page {
            Column {
                anchors.centerIn: parent
                spacing: 6
                Label {
                    text: (i18n.locale, i18n.tr("wizard.ffmpegPath"))
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 6
                    ComboBox {
                        id: ffmpegPathComboBox
                        editable: true
                        width: 200
                        currentValue: settings.get("ffmpeg-path")[0] ?? sysfetch.getFFmpegPath()[0]
                        model: {
                            if (!sysfetch.getFFmpegPath().length)
                                return [(locale, i18n.tr("wizard.ffmpegPath.noFFmpeg"))];
                            var arr = [];
                            for (var i = 0; i < sysfetch.getFFmpegPath().length; i++) {
                                arr.push(sysfetch.getFFmpegPath()[i]);
                            }
                            return arr;
                        }
                        onCurrentValueChanged: {
                            nextButton.enabled = true;
                        }
                        Text {
                            text: (i18n.locale, i18n.tr("wizard.ffmpegPath.hint"))
                            color: "gray"
                            anchors.fill: ffmpegPathComboBox.contentItem
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            visible: ffmpegPathComboBox.contentItem.text === "" && !ffmpegPathComboBox.contentItem.activeFocus
                            padding: 4
                        }
                    }
                    Button {
                        onClicked: {
                            var path = sysfetch.openFile("ffmpeg*", (i18n.locale, i18n.tr("wizard.ffmpegPath.browse")));
                            if (path) {
                                ffmpegPathComboBox.model.push(path);
                                ffmpegPathComboBox.currentValue = path;
                            }
                        }
                        width: ffmpegPathComboBox.height
                        height: ffmpegPathComboBox.height
                        leftPadding: ffmpegPathComboBox.height - 24
                        rightPadding: ffmpegPathComboBox.height - 24
                        icon.source: "image://fa/folder-open"
                    }
                    BusyIndicator {
                        width: 20
                    }
                }
                Text {
                    text: (i18n.locale, i18n.tr("wizard.ffmpegPath.invalidFFmpeg"))
                    color: "red"
                    visible: !nextButton.enabled
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 12
                    Button {
                        text: (i18n.locale, i18n.tr("wizard.back"))
                        onClicked: stack.pop()
                        icon.source: "image://fa/arrow-left"
                    }
                    Button {
                        id: nextButton
                        text: (i18n.locale, i18n.tr("wizard.next"))
                        onClicked: () => {
                            if (sysfetch.verifyFFmpeg(ffmpegPathComboBox.currentText)) {
                                settings.set("ffmpeg-path", ffmpegPathComboBox.currentText);
                                stack.push(finalPage);
                            } else {
                                ffmpegPathComboBox.forceActiveFocus();
                                nextButton.enabled = false;
                            }
                        }
                        icon.source: "image://fa/arrow-right"
                    }
                }
            }
        }
    }
    Component {
        id: finalPage
        Page {
            Column {
                anchors.centerIn: parent
                spacing: 12
                Label {
                    text: (i18n.locale, i18n.tr("wizard.finish"))
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Label {
                    text: (i18n.locale, i18n.tr("wizard.finish.hint"))
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 12
                    Button {
                        text: (i18n.locale, i18n.tr("wizard.back"))
                        onClicked: stack.pop()
                        icon.source: "image://fa/arrow-left"
                    }
                    Button {
                        text: (i18n.locale, i18n.tr("wizard.finish"))
                        icon.source: "image://fa/check"
                        onClicked: Qt.quit()
                    }
                }
            }
        }
    }
}
