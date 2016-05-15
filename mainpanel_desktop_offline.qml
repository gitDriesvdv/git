import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Enginio 1.0
import QtQuick.Controls.Styles 1.2

ApplicationWindow {
    id: main
    title: qsTr("Mainpanel")
    height: Screen.height
    width: Screen.width
    visible: true
    color: "white"
    Label {
                        id: label
                        text: "Loading your mainpanel..."
                        font.pixelSize: 28
                        color: "black"
                        anchors.centerIn: parent
                        visible: view.status !== TabView.Ready
                    }
    Row {
        id: leftrow
        height: main.height
        Rectangle {
            id: head
            height: 100
            //z:1
            color: "white"
            /*Text {
                id: headertext
                text: qsTr("Dries")
                color: "white"
                font.pointSize: 24
                x: 60
                y: 50
            }*/
        }
        Column {
            id: col
            height: Screen.height
            anchors.top: head.bottom
            Repeater {
                model: view.count
                Rectangle {
                    width: 200
                    height: 70
                    color: "white"
                    border.width: 0
                    Text {
                        id: tekst
                        anchors.centerIn: parent
                        text: view.getTab(index).title
                        color: "gray"
                    }
                    Rectangle{
                        id: lijn
                        anchors.top: tekst.bottom
                        height: 2
                        width: 100
                        color: "red"
                        x: 50
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: view.currentIndex = index
                    }
                }
            }
        }
        TabView {
            id: view
            width: Screen.width
            height: Screen.height
            style: TabViewStyle {
                tab: Rectangle {
                   // border.color:"white"
                    radius: 2
                }
            }
            Tab {
                title: "Users"
                Users { anchors.fill: parent }
            }
            Tab {
                title: "Create new form"
                FormbuilderV2 { anchors.fill: parent }
            }
            Tab {
                title: "Results"
                FormResults { anchors.fill: parent }
            }
            Tab {
                title: "Settings"
                Settings { anchors.fill: parent }
            }/*
            Tab {
                title: "Logbook"
                Rectangle { anchors.fill: parent }
            }*/
        }
    }

}

