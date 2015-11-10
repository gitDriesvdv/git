import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0
Rectangle {
    id: rec
    width: Screen.width
    height: Screen.height

    //![identity]
    EnginioOAuth2Authentication {
        id: identity
        user: login.text
        password: password.text
    }
    EnginioClient {
        id: enginioClient
        backendId: "54be545ae5bde551410243c3"

        onError:{
            console.debug(JSON.stringify(reply.data))
            enginioModelErrors.append({"Error": "Enginio " + JSON.stringify(reply.data) + "\n\n", "User": "Admin"})
        }
    }
    EnginioModel {
        id: enginioModel
        client: enginioClient
        query: {"objectType": "objects.OS_components",
                "include": {"file": {}},
                "query" : { "type": Qt.platform.os, "name" : "mainpanel_desktop" } }
    }
    EnginioModel {
        id: enginioModelErrors
        client: enginioClient
        query: {
            "objectType": "objects.Errors"
        }

    }
    EnginioModel {
        id: enginioModelLogs
        client: enginioClient
        query: {
            "objectType": "objects.Logs"
        }
    }
    //![identity]
    anchors.fill: parent
    anchors.margins: 0
    //spacing: 3

    GridLayout{
        columns: 2
        Rectangle{
        id: loginscreen
        width: rec.width/2
        height: rec.height
        color: "#23617B"

        Rectangle{
            anchors.centerIn: parent
            TextField {
                id: login
                Layout.fillWidth: true
                placeholderText: "Username"
                enabled: enginioClient.authenticationState == Enginio.NotAuthenticated
            }

            TextField {
                id: password
                anchors.top: login.bottom
                Layout.fillWidth: true
                placeholderText: "Password"
                echoMode: TextInput.PasswordEchoOnEdit
                enabled: enginioClient.authenticationState == Enginio.NotAuthenticated
            }

            Button {
                id: proccessButton
                 anchors.top: password.bottom
                Layout.fillWidth: true
                //text: "Login"
                //onClicked: root.visible = true
            }
        }


        }
        Rectangle{
            width: rec.width/2
            height: rec.height
            anchors.left: loginscreen.right
            color: "#23617B"
            Rectangle{
                anchors.centerIn: parent
                ColumnLayout {
                    anchors.margins: 1
                    spacing: 3

                    TextField {
                        id: login_R
                        Layout.fillWidth: true
                        placeholderText: "Username (required)"
                    }

                    TextField {
                        id: password_R
                        Layout.fillWidth: true
                        placeholderText: "Password (required)"
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
                        placeholderText: "Email (required)"
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                    }
                    Text{
                        id: val_text
                        text: ""
                        Layout.fillWidth: true
                    }

                    Button {
                        id: proccessButton_R
                        Layout.fillWidth: true
                        enabled: login_R.text.length >= 10 && password_R.text.length >= 7
                        text: "Register"

                        states: [
                            State {
                                name: "Registering"
                                PropertyChanges {
                                    target: proccessButton_R
                                    text: "Registering..."
                                    enabled: false
                                }
                            }
                        ]

                        onClicked: {
                            proccessButton_R.state = "Registering"
                            //![create]

                            if(validateEmail(userEmail.text) == false)
                            {
                                val_text.text = "Fill in a valid email"
                            }
                            else
                            {
                            var reply = enginioClient.create(
                                        { "username": login_R.text,
                                          "password": password_R.text,
                                          "email": userEmail.text,
                                          "firstName": userFirstName.text,
                                          "lastName": userLastName.text
                                        }, Enginio.UserOperation)
                            //![create]
                            reply.finished.connect(function() {
                                    proccessButton_R.state = ""
                                    if (reply.errorType !== EnginioReply.NoError) {
                                        log.text = "Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                                        enginioModelErrors.append({"Error": "Enginio " + log.text + "\n\n", "User": login.text})

                                    } else {
                                        log.text = "Account Created.\n"
                                        enginioModelLogs.append({"Log": log.text, "User": login.text})
                                        //root.visible = true

                                    }
                                })
                            }
                        }
                    }

                    TextArea {
                        id: log
                        readOnly: true
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        visible: false
                    }
                }
            }
        }
    }





    TextArea {
        id: data
        text: "Not logged in.\n\n"
        readOnly: true
        Layout.fillHeight: true
        Layout.fillWidth: true
        visible: false

        //![connections]
        Connections {
            target: enginioClient
            onSessionAuthenticated: {
                data.text = data.text + "User '"+ login.text +"' is logged in.\n\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                enginioModelLogs.append({"Log": data.text, "User": login.text})
                var component = Qt.createComponent("mainpanel_test.qml")
                var window    = component.createObject(rec)
                window.show()
                //gridview.visible = true;
                //root.visible = true;

            }
            onSessionAuthenticationError: {
                data.text = data.text + "Authentication of user '"+ login.text +"' failed.\n\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                enginioModelErrors.append({"Error": "Enginio " + data.text + "\n\n", "User": login.text})

            }
            onSessionTerminated: {
                data.text = data.text + "Session closed.\n\n"
            }
        }
        //![connections]
    }

    states: [
        State {
            name: "NotAuthenticated"
            when: enginioClient.authenticationState == Enginio.NotAuthenticated
            PropertyChanges {
                target: proccessButton
                text: "Login"
                onClicked: {
                    //![assignIdentity]
                    enginioClient.identity = identity
                    //![assignIdentity]
                }
            }
        },
        State {
            name: "Authenticating"
            when: enginioClient.authenticationState == Enginio.Authenticating
            PropertyChanges {
                target: proccessButton
                text: "Authenticating..."
                enabled: false
            }
        },
        State {
            name: "AuthenticationFailure"
            when: enginioClient.authenticationState == Enginio.AuthenticationFailure
            PropertyChanges {
                target: proccessButton
                text: "Login failed, restart"
                onClicked: {
                    enginioClient.identity = null
                }
            }
        },
        State {
            name: "Authenticated"
            when: enginioClient.authenticationState == Enginio.Authenticated
            PropertyChanges {
                target: proccessButton
                text: "Logout"
                onClicked: {
                    //![assignNull]
                    enginioClient.identity = null
                    //![assignNull]
                }
            }
        }
    ]
    /*Rectangle {
        id: root
       // anchors.fill: rec
        visible: false
        //opacity: 1
        color: "blue"
        width: Screen.width
        height: Screen.height

        Item{
            id: griddelegate
            Rectangle{

                width: Screen.width
                height: Screen.height

            Loader {
                id: mainloader_2
                width: Screen.width
                height: Screen.height
                //anchors.verticalCenter: rec.verticalCenter
                anchors.verticalCenter: parent.verticalCenter

                Behavior on opacity { NumberAnimation { duration: 100 } }
                focus: true
                //Dit is voor QML uit database
               /* Component.onCompleted: {
                    mainloader.source = ""
                        var data = { "id": file.id }
                        var reply = client.downloadUrl(data)
                        reply.finished.connect(function() {
                            mainloader.source = reply.data.expiringUrl
                        })
                }*/

                //Dit gebruiken voor de testen
              /* source : "qrc:/mainpanel_test.qml"
            }
            }
        }
        GridView{
            id: gridview
            visible: false
            model: enginioModel2
            delegate: griddelegate
            width: Screen.width
            height: Screen.height
            //anchors.fill: root
            x:0
            y:0
        }

        EnginioClient {
            id: client
            backendId: "54be545ae5bde551410243c3"
            onError: console.log("Enginio error: " + reply.errorCode + ": " + reply.errorString)
        }
        EnginioModel {
            id: enginioModel2
            client: client
            query: {"objectType": "objects.OS_components",
                    "include": {"file": {}},
                    "query" : { "type": Qt.platform.os, "name" : "mainpanel_desktop" } }
        }
    }*/
    //bron: http://stackoverflow.com/questions/23652378/javascript-adding-email-validation-function-to-existing-validation-function
    function validateEmail(email)
    {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
    }
}



