import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0
Rectangle {
    //height: 400
    //width: 400
    //![identity]
    EnginioOAuth2Authentication {
        id: identity
        user: login.text
        password: password.text
    }
    EnginioClient {
        id: enginioClient
        backendId: "54be545ae5bde551410243c3"

        onError: console.debug(JSON.stringify(reply.data))
    }
    /*EnginioModel {
        id: enginioModel
        client: enginioClient
        query: {"objectType": "objects.OS_components",
                "include": {"file": {}},
                "query" : { "type": Qt.platform.os, "name" : "mainpanel_desktop" } }
    }*/
    //![identity]
    anchors.fill: parent
    anchors.margins: 3
    //spacing: 3

    Rectangle{
    id: loginscreen
    width: Screen.width/2
    height: Screen.height
   // x: 0
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
            //onClicked: createSpriteObjects();
        }
        Button {
            id: proccessButton2
             anchors.top: proccessButton.bottom
            Layout.fillWidth: true
            onClicked: root.visible = true
        }
    }


    }
    Rectangle{
        width: Screen.width/2
        height: Screen.height
        anchors.left: loginscreen.right
        color: "#23617B"
        Rectangle{
            anchors.centerIn: parent
            ColumnLayout {
                anchors.margins: 3
                spacing: 3

                TextField {
                    id: login_R
                    Layout.fillWidth: true
                    placeholderText: "Username"
                }

                TextField {
                    id: password_R
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
                    id: proccessButton_R
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
                                    { "username": login_R.text,
                                      "password": password_R.text,
                                      "email": userEmail.text,
                                      "firstName": userFirstName.text,
                                      "lastName": userLastName.text
                                    }, Enginio.UserOperation)
                        //![create]
                        reply.finished.connect(function() {
                                proccessButton.state = ""
                                if (reply.errorType !== EnginioReply.NoError) {
                                    log.text = "Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                                } else {
                                    log.text = "Account Created.\n"
                                }
                            })
                    }
                }

                /*TextArea {
                    id: log
                    readOnly: true
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }*/
            }
        }
    }
    Rectangle {
        id: root
        anchors.fill: parent
        visible: false
        opacity: 1
        color: "#f4f4f4"

        EnginioClient {
            id: client
            backendId: "54be545ae5bde551410243c3"
            onError: console.log("Enginio error: " + reply.errorCode + ": " + reply.errorString)
        }
        EnginioModel {
            id: enginioModel
            client: client
            query: {"objectType": "objects.OS_components",
                    "include": {"file": {}},
                    "query" : { "type": Qt.platform.os, "name" : "mainpanel_desktop" } }
        }

        Component {
            id: listDelegate

            BorderImage {
                height: main.height
                width: main.width
                border.top: 4
                border.bottom: 4
                source: "qrc:/new/prefix1/delegate kopie.png"

                Loader {
                    id: mainloader
                    width: main.width
                    height: main.height
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on opacity { NumberAnimation { duration: 100 } }

                    //Dit is voor QML uit database
                    Component.onCompleted: {
                        mainloader.source = ""
                            var data = { "id": file.id }
                            var reply = client.downloadUrl(data)
                            reply.finished.connect(function() {
                                mainloader.source = reply.data.expiringUrl
                            })
                    }

                    //Dit gebruiken voor de testen
                    //source : "Login_desktop.qml"
                }
                Rectangle {
                    color: "transparent"
                    anchors.fill: mainloader
                    border.color: "#aaa"
                    Rectangle {
                        id: progressBar
                        property real value:  image.progress
                        anchors.bottom: parent.bottom
                        width: mainloader.width * value
                        height: 40
                        color: "#49f"
                        opacity: mainloader.status != Loader.Ready ? 1 : 0
                        Behavior on opacity {NumberAnimation {duration: 100}}
                    }
                }
            }
        }

        Rectangle {
            id: header
            anchors.top: parent.top
            width: parent.width
            height: 0
            color: "white"
        }

        Row {
            id: listLayout

            Behavior on x {NumberAnimation{ duration: 400 ; easing.type: "InOutCubic"}}
            anchors.top: header.bottom
            anchors.bottom: footer.top

            ListView {
                id: listView
                model: enginioModel // get the data from EnginioModel
                delegate: listDelegate
                clip: true
                width: root.width
                height: parent.height
            }
        }

        BorderImage {
            id: footer
            height: 0
            width: parent.width
            anchors.bottom: parent.bottom
            source: addMouseArea.pressed ? "qrc:images/delegate_pressed.png" : "qrc:images/delegate.png"
        }
    }

   /* TextArea {
        id: data
        text: "Not logged in.\n\n"
        readOnly: true
        Layout.fillHeight: true
        Layout.fillWidth: true

        //![connections]
        Connections {
            target: enginioClient
            onSessionAuthenticated: {
                data.text = data.text + "User '"+ login.text +"' is logged in.\n\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
            }
            onSessionAuthenticationError: {
                data.text = data.text + "Authentication of user '"+ login.text +"' failed.\n\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
            }
            onSessionTerminated: {
                data.text = data.text + "Session closed.\n\n"
            }
        }
        //![connections]
    }*/

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
                text: "Authentication failed, restart"
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
}



