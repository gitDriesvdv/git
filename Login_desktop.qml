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
Rectangle {
    id: rec
    width: Screen.width
    height: Screen.height

    Settings {
           id: settings
           property string username: ""
           property string my_id: ""
           property string myBackendId: settings.myBackendId
       }
    //![identity]
    EnginioOAuth2Authentication {
        id: identity
        user: login.text
        password: password.text
    }
    EnginioClient {
        id: enginioClient
        backendId: settings.myBackendId

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
Rectangle{
    id: top
    width: Screen.width
    height: Screen.height / 3
    color: "white"
    Image {
        id: logo
        source: "qrc:/new/prefix1/Schermafdruk 2016-01-26 17.19.42.png"
        anchors.centerIn: parent
        y:50
        //height: parent.height/0.8
        width: 180
    }
}
Rectangle{
    id :bot
    width: Screen.width
    height: Screen.height / 3
    anchors.top : top.bottom

    GridLayout{
        id: col
        columns: 2
        Rectangle{
        id: loginscreen
        width: rec.width/2
        height: rec.height
        color: "white"

        Rectangle{
            //anchors.centerIn: parent
            x: Screen.width/4
            y: 100
            TextField {
                id: login
                Layout.fillWidth: true
                placeholderText: "USERNAME"
                enabled: enginioClient.authenticationState == Enginio.NotAuthenticated
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
                enabled: enginioClient.authenticationState == Enginio.NotAuthenticated
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
                onClicked: FileIO.save("test tekst");
            }
        }


        }

        Rectangle{
            width: rec.width/2
            height: rec.height
            anchors.left: loginscreen.right
            color: "white"
            Rectangle{
                x: Screen.width/5
                y: 100
                ColumnLayout {
                    anchors.margins: 1
                    spacing: 9

                    TextField {
                        id: login_R
                        Layout.fillWidth: true
                        placeholderText: "Username (required)"
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
                        Rectangle{
                            width: login.width
                            height: 2
                            color: "red"
                             anchors.top: login_R.bottom
                        }
                    }

                    TextField {
                        id: password_R
                        Layout.fillWidth: true
                        placeholderText: "Password (required)"
                        echoMode: TextInput.PasswordEchoOnEdit
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
                        Rectangle{
                            width: login.width
                            height: 2
                            color: "red"
                             anchors.top: password_R.bottom
                        }
                    }

                    TextField {
                        id: userFirstName
                        Layout.fillWidth: true
                        placeholderText: "First name"
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
                        Rectangle{
                            width: login.width
                            height: 2
                            color: "red"
                             anchors.top: userFirstName.bottom
                        }
                    }

                    TextField {
                        id: userLastName
                        Layout.fillWidth: true
                        placeholderText: "Last name"
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
                        Rectangle{
                            width: login.width
                            height: 2
                            color: "red"
                             anchors.top: userLastName.bottom
                        }
                    }

                    TextField {
                        id: userEmail
                        Layout.fillWidth: true
                        placeholderText: "Email (required)"
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
                        inputMethodHints: Qt.ImhEmailCharactersOnly
                        Rectangle{
                            width: login.width
                            height: 2
                            color: "red"
                             anchors.top: userEmail.bottom
                        }
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
                            //plans.visible = true;
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
                                          "lastName": userLastName.text,
                                          "admin": true,
                                          "myAdmin":login_R.text
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
                console.log("CHECK: " + login.text);
                getDataUserForms(login.text)
                settings.username = login.text
                var component = Qt.createComponent("mainpanel_desktop_offline.qml")
                if (component.status == Component.Ready) {
                var window    = component.createObject(rec);
                window.show()
                }

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

    Rectangle{
        id: plans
        width: rec.width/1.5
        height: rec.height/1.5
        color: "transparent"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        Rectangle{
            id: plan1
            width: plans.width/3
            height: plans.height
            color: "blue"
        }
        Rectangle{
            id: plan2
            width: plans.width/3
            height: plans.height
            color: "green"
            anchors.left: plan1.right
        }
        Rectangle{
            id: plan3
            width: plans.width/3
            height: plans.height
            color: "yellow"
            anchors.left: plan2.right
        }
    }
}


    //bron: http://stackoverflow.com/questions/23652378/javascript-adding-email-validation-function-to-existing-validation-function
    function validateEmail(email)
    {
        var re = /\S+@\S+\.\S+/;
        return re.test(email);
    }
    function getDataUserForms(formname_input) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"username\":\""+ formname_input +"\"}&limit=1"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                console.log(arr1)
                for(var i = 0; i < arr1.length; i++) {
                    console.log(arr1[i].id);
                    settings.my_id = arr1[i].id;
                }
            }
            else
            {
                console.log("Bad request")
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.setRequestHeader("Enginio-Backend-Id",settings.myBackendId);
        xmlhttp.send();
    }
}



