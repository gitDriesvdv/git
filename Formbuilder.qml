import QtQuick 2.0
import QtQuick.Layouts 1.1
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0

Rectangle {
    width: Screen.width
    height: Screen.height
    GridLayout {
        id: grid
        columns: 2
        columnSpacing: 40

        Button{
            id: firstbutton
            text: "Test"
            enabled: false
        }
    }
    Rectangle{
        //anchors.fill: parent
        width: Screen.width - grid.width
        height: Screen.height - grid.height
        anchors.left: grid.right
        color: "gray"
        Text{
            text: "Click here to start new form..."
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                enableButtons();
            }
        }
    }
    function enableButtons()
    {
        firstbutton.enabled = true;
    }
}

