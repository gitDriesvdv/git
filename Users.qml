import QtQuick 2.0
import Enginio 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
Rectangle{
    //height: 800
    //width: 1000
    anchors.fill: parent

    EnginioClient {
        id: enginioClient
        backendId: "54be545ae5bde551410243c3"
        onError: {console.debug(JSON.stringify(reply.data))
        enginioModelErrors.append({"Error": "Enginio " + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
        }
    }

    EnginioModel {
        id: enginioModelLogs
        client: enginioClient
        query: {
            "objectType": "objects.Logs"
        }
    }

    EnginioModel {
        id: enginioModelErrors
        client: enginioClient
        query: {
            "objectType": "objects.Errors"
        }
    }

    /*Rectangle{
        id: userlist
        x: 20
        y: 20
        color: "green"
        height: Screen.height/2
        width: Screen.width*/

    Row {
        id: topRij
    anchors.margins: 3
    spacing: 3
    height: Screen.height/2
    width: Screen.width
    Rectangle{
        id: left
        height: Screen.height/2
        width: Screen.width/1.5
        TableView {
            id: tabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            height: Screen.height/2
            width: Screen.width/1.5
            style: TableViewStyle{
                //backgroundColor: "white"
                alternateBackgroundColor :"white"
            }
           onClicked: {
               editButton.enabled = true
               deleteButton.enabled = true
           }

            TableViewColumn { title: "First name"; role: "firstName" }
            TableViewColumn { title: "Last name"; role: "lastName" }
            TableViewColumn { title: "Login"; role: "username" }
            TableViewColumn { title: "Email"; role: "email" }

            model: EnginioModel {
                id: enginioModel
                client: enginioClient
                operation: Enginio.UserOperation
                query: {"objectType": "users" }
            }
        }
    }


Rectangle{
    anchors.left: left.right
    width: Screen.width/4
    ColumnLayout{
        anchors.left: left.right
        width: Screen.width/4
        height: Screen.height/4
        x:10
        y:10
        Button {
            text: "Refresh"
            anchors.left: tabel.right
            width: Screen.width/4.5
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
            onClicked: {
                var tmp = enginioModel.query
                enginioModel.query = null
                enginioModel.query = tmp
            }
        }
        Button {
            id: deleteButton
            text: "delete"
            enabled:  false
            anchors.left: tabel.right
            width: Screen.width/4.5
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
            onClicked: {
                enginioModel.remove(tabel.currentRow);
                /*var tmp = enginioModel.query
                enginioModel.query = null
                enginioModel.query = tmp*/
            }
        }
        Button {
            id: editButton
            text: "edit"
            anchors.left: tabel.right
            enabled:  false
            width: Screen.width/4.5
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
            onClicked: {
                /*var tmp = enginioModel.query
                enginioModel.query = null
                enginioModel.query = tmp*/
                console.log()
            }
        }
    }


    }
}
   // }

    Row {
        anchors.top: topRij.bottom
        width: Screen.width

        Rectangle {
            id: first
            anchors.left: parent.left
            color: "white";
            width: parent.width/4;
            height: 50 }

        Rectangle{
            id: spacer
            width: 2
            color: "red"
            height: 200
            anchors.left: first.right
        }

        Rectangle {
            id: second
            anchors.left: spacer.right
            color: "white";
            width: parent.width/4;
            height: 50 }
        Rectangle{
            id: spacer2
            width: 2
            color: "red"
            height: 200
            anchors.left: second.right
        }
        Rectangle {
            id : addUser
            color: "blue";
            anchors.left: spacer2.right
            width: parent.width/4
        MessageDialog {
                id: messageDialog
                title: "Message"
            }
    ColumnLayout {
        x: 10
        anchors.margins: 3
        spacing: 3

        TextField {
            id: login
            Layout.fillWidth: true
            placeholderText: "Username"
        }

        TextField {
            id: password
            Layout.fillWidth: true
            placeholderText: "Password"
            echoMode: TextInput.PasswordEchoOnEdit
        }

        TextField {
            id: userFirstName
            Layout.fillWidth: true
            placeholderText: "First name"
        }

        TextField {
            id: userLastName
            Layout.fillWidth: true
            placeholderText: "Last name"
        }

        TextField {
            id: userEmail
            Layout.fillWidth: true
            placeholderText: "Email"
        }

        Button {
            id: proccessButton
            Layout.fillWidth: true
            enabled: login.text.length && password.text.length
            text: "Register"

            states: [
                State {
                    name: "Registering"
                    PropertyChanges {
                        target: proccessButton
                        text: "Registering..."
                        enabled: false
                    }
                }
            ]

            onClicked: {
                proccessButton.state = "Registering"
                //![create]
                var reply = enginioClient.create(
                            { "username": login.text,
                              "password": password.text,
                              "email": userEmail.text,
                              "firstName": userFirstName.text,
                              "lastName": userLastName.text,
                              "myAdmin" : settings.username
                            }, Enginio.UserOperation)

                reply.finished.connect(function() {

                        proccessButton.state = ""
                        if (reply.errorType !== EnginioReply.NoError) {
                            messageDialog.text = "Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                            enginioModelErrors.append({"Error": login.text + " Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n", "User": "Admin"})
                        } else {
                            messageDialog.text = "Account Created.\n"
                            enginioModelLogs.append({"Log": login.text + " Account Created", "User": "Admin"})
                            login.text = ""
                            password.text = ""
                            userEmail.text = ""
                            userFirstName.text = ""
                            userLastName.text = ""
                        }
                        messageDialog.visible = true;
                    })
            }
        }

    }
    }

    }
    function getDataUserForms(formname_input) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"username\":\""+ formname_input +"\"}&limit=1"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                for(var i = 0; i < arr1.length; i++) {
                    console.log(arr1[i].forms);
                    for(var y = 0; y < arr1[i].forms.length; y++)
                    {
                        lijstmodel.append({text: arr1[i].forms[y]})
                    }
                }
            }
            else
            {
                console.log("Bad request")
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.setRequestHeader("Enginio-Backend-Id","54be545ae5bde551410243c3");
        xmlhttp.send();
    }
}


