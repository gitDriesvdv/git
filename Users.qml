import QtQuick 2.0
import Enginio 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.1
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

    Rectangle{
        id: userlist
        height: 400
        width: 800

    ColumnLayout {


    anchors.margins: 3
    spacing: 3
    height: 400
    width: 800
    TableView {
        Layout.fillWidth: true
        Layout.fillHeight: true

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

    Button {
        text: "Refresh"
        Layout.fillWidth: true

        onClicked: {
            var tmp = enginioModel.query
            enginioModel.query = null
            enginioModel.query = tmp
        }
    }
}
    }


    Rectangle{
        id : addUser
        anchors.top: userlist.bottom

        MessageDialog {
            id: messageDialog
            title: "Message"
        }
ColumnLayout {
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


