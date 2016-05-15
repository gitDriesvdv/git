import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4


Rectangle{

    id: setting_page
    width: parent.width
    height: parent.height

    Row {
        id: topRij
    anchors.margins: 3
    spacing: 3
    height: parent.height/2
    width: parent.width
    Rectangle
    {
        id: leftPage
        width: setting_page.width / 2
        height: setting_page.height / 2
        color: "red"

    }
    Rectangle{
        id: rightPage
        width: setting_page.width / 2
        height: setting_page.height / 2
        color: "blue"
    }
    }
}

