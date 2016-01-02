import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
Rectangle {
    id :rect
    width: parent.width
   height: parent.height
    color: "gray"
    TabView {
        anchors.fill: parent
        Tab {
            title: "Users"
            Users { anchors.fill: parent }
        }
        Tab {
            title: "Blue"
            Rectangle { color: "blue" }
        }
        Tab {
            title: "Green"
            Rectangle { color: "green" }
        }
    }
}

