import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Enginio 1.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

ApplicationWindow {
    id: main
    title: qsTr("Mainpanel")
    height: Screen.height
    width: Screen.width
    visible: true
    color: "#1C353C"

    Label {
       id: label
       text: "Loading your mainpanel..."
       font.pixelSize: 28
       color: "black"
       anchors.centerIn: parent
       visible: view.status !== TabView.Ready
    }

    RowLayout {
        id: headerRow
        height: 50
        width: Screen.width
        y : -10
        Rectangle{
            color: "#1C353C"
            width: 10
            height: 40
            x:0
        }

        Rectangle{
            id: header
            height: 50
            width: Screen.width - 30
            color: "#39AEE6"
            radius: 5
            Rectangle{
                anchors.left: parent.left
                height: 50
                width: 200
                color: "#39AEE6"
                Text{
                    id: projectname
                    y:20
                    x:50
                    text: "Form"
                    color: "white"
                    font.pixelSize: 20
                    font.family: "Helvetica"
                }
            }


            Rectangle{
                anchors.right: parent.right
                height: 50
                width: 300
                color: "#39AEE6"

                //bron: Ben Sperry, http://fa2png.io/r/ionicons/ios-contact-outline/
                Image {
                    id: adminlogo
                    source: "qrc:/../Downloads/contact-outline.png"
                    width: 40
                    height: 40
                    y:10
                }
                Text{
                    id: adminname
                    y:20
                    font.pixelSize: 16
                    color: "white"
                    text: settings.username
                    anchors.left: adminlogo.right
                }
                Rectangle{
                    id:spacerHorizontal
                    width: 10
                    height: 40
                    anchors.left: adminname.right
                    color: "#39AEE6"
                }

                Button{
                    id: logoutButton
                    text:"logout"
                    y:15
                    anchors.left: spacerHorizontal.right
                    style: ButtonStyle {
                            background: Rectangle {
                                implicitWidth: 50
                                implicitHeight: 25
                                border.width: 0
                                border.color: "#39AEE6"
                                radius: 4
                                gradient: Gradient {
                                    GradientStop { position: 0 ; color: control.pressed ? "#39AEE6" : "#39AEE6" }
                                    GradientStop { position: 1 ; color: control.pressed ? "#39AEE6" : "#39AEE6" }
                                }
                            }
                        }
                }
            }


        }
        Rectangle{
            color: "#1C353C"
            width: 10
        }
    }


    Rectangle{
        id: spacer
        height: 20
        width: Screen.width
        anchors.top: headerRow.bottom
        color: "#1C353C"
    }

    TabView {
        id: view
        anchors.top: spacer.bottom
        width: Screen.width - 100
        height: Screen.height - 100
        x:50
        y:50

        style: TabViewStyle {
               frameOverlap: 1
               tab: Rectangle {
                   color: styleData.selected ? "white" :"#31464C"
                   implicitWidth: 150
                   implicitHeight: 40
                   radius: 0
                   Text {
                       id: text
                       y:10
                       anchors.centerIn: parent
                       text: styleData.title
                       color: styleData.selected ? "#4BB43A" : "white"
                   }
               }
               frame: Rectangle { color: "steelblue" }
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
    }
}

