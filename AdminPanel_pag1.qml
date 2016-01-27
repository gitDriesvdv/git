import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4

Rectangle {

    id: mainpanel
    width: Screen.width
    height: Screen.height
    color: "white"

    Rectangle{
        id: formulier
        width: Screen.width/2
        height: Screen.height
        TextField {
            id: login
            Layout.fillWidth: true
            placeholderText: "USERNAME"
            style: TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {
                        radius: 2
                        border.color: "red"
                        border.width: 0
                    }
                }
        }
        Rectangle{
            id: line
            width: login.width
            height: 2
            color: "red"
             anchors.top: login.bottom
        }
        Rectangle{
            id: spacer
            width: login.width
            height: 10
            color: "white"
             anchors.top: line.bottom
        }
        TextField {
            id: password
            anchors.top: spacer.bottom
            Layout.fillWidth: true
            placeholderText: "PASSWORD"
            style: TextFieldStyle {
                    textColor: "black"
                    background: Rectangle {
                        radius: 2
                        //implicitWidth: 100
                        //implicitHeight: 24
                        border.color: "red"
                        border.width: 0
                    }
                }
            echoMode: TextInput.PasswordEchoOnEdit
        }
        Rectangle{
            id: line2
            width: login.width
            height: 2
            color: "red"
             anchors.top: password.bottom
        }
        Rectangle{
            id: spacer2
            width: login.width
            height: 10
            color: "white"
             anchors.top: line2.bottom
        }
        Button {
            id: proccessButton
             anchors.top: spacer2.bottom
            Layout.fillWidth: true
            width: password.width
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 25
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "red"
                        radius: 9
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            //text: "Login"
            //onClicked: root.visible = true
        }
    }


    //bedrijfsinformatie ophalen uit de database

    //mogelijkheid voor aanpassingen

    //foto of logo van het bedrijf kunnen oploaden

    //
}

