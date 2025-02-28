import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Pisces.Calculator 1.0
import Qt.labs.platform 1.0
import FishUI 1.0 as FishUI

FishUI.Window {
    id: rootWindow
    width: 350
    height: 550
    minimumWidth: 350
    minimumHeight: 550
    title: qsTr("Calculator")

    background.color: FishUI.Theme.darkMode ? Qt.rgba(46 / 255, 46 / 255, 46 / 255, 1.0)
                                            : Qt.rgba(240 / 255, 238 / 255, 241 / 255, 1.0)
    background.opacity: rootWindow.compositing ? 0.95 : 1.0

    MenuBar {
        id: menuBar

        Menu {
            id: helpMenu
            title: qsTr("Help")

            MenuItem {
                text: qsTr("About")
                onTriggered: aboutDialog.show()
            }
        }
    }

    FishUI.AboutDialog {
        id: aboutDialog
        name: rootWindow.title
        description: qsTr("A simple calculator")
        iconSource: "image://icontheme/pisces-calculator"
    }

    FishUI.WindowBlur {
        view: rootWindow
        geometry: Qt.rect(rootWindow.x, rootWindow.y, rootWindow.width, rootWindow.height)
        windowRadius: rootWindow.background.radius
        enabled: true
    }

    CalcEngine {
        id: calcEngine

        Component.onCompleted: {
            console.log("load calc engine finished")
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: FishUI.Units.smallSpacing

        Zone {
            id: zone
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height * 0.35
        }

        StandardPad {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                z: -1
                anchors.fill: parent
                color: FishUI.Theme.secondBackgroundColor
                opacity: 0.9
            }

            onPressed: zone.appendToTextField(text)
        }
    }

    function calculate(evalText) {
        var res = calcEngine.eval(evalText)
        return res
    }
}
