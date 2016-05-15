import QtQuick 2.0
import Enginio 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0

Rectangle{
    //height: 800
    //width: 1000
    anchors.fill: parent
    property string client_id_edit: ""
    Component.onCompleted: {
        getDataUsers();
    }

    EnginioClient {
        id: enginioClient
        backendId: settings.myBackendId
        onError: {
        console.debug(JSON.stringify(reply.data))
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

    EnginioModel {
        id: enginioModelUsers
        client: enginioClient
        operation: Enginio.UserOperation
        query: {"objectType": "users" }
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
                alternateBackgroundColor :"white"
            }
           onClicked: {
               deleteButton.enabled = true
               client_id_edit = tabel.model.get(row).id
               editlogin.text = tabel.model.get(row).username
               edituserEmail.text = tabel.model.get(row).email
               edituserFirstName.text = tabel.model.get(row).firstName
               edituserLastName.text = tabel.model.get(row).lastName
           }

            TableViewColumn { title: "Id"; role: "id" }
            TableViewColumn { title: "First name"; role: "firstName" }
            TableViewColumn { title: "Last name"; role: "lastName" }
            TableViewColumn { title: "Login"; role: "username" }
            TableViewColumn { title: "Email"; role: "email" }

            //dit verwijderen als enginio terug werkt omdat op windows problemen met ssl
            model: ListModel {
                id: tabelmodel
            }

            //dit terugzetten als enginio terug werkt
            /*model: EnginioModel {
                id: enginioModel
                client: enginioClient
                operation: Enginio.UserOperation
                query: {"objectType": "users" }
            }*/
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
                getDataUsers()
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

                //overzetten naar Enginio zodat de data in de database ook verwijderd zal worden
                tabelmodel.remove(tabel.currentRow);
            }
        }
        /*Button {
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
                login.text = tabel.model.get(row).firstName
                /*var tmp = enginioModel.query
                enginioModel.query = null
                enginioModel.query = tmp
                console.log()
            }
        }*/
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
            color: "gray";
            width: parent.width/4;
            height: 200

            //2 listviews naast elkaar met in het midden 2 buttons < en >

            Rectangle{
                id: first_left
                width: first.width/2.3
                height: first.height
                ListModel {
                    id: contactModel
                    ListElement {
                        name: "Bill Smith"
                    }
                    ListElement {
                        name: "John Brown"
                    }
                    ListElement {
                        name: "Sam Wise"
                    }
                }
                Component{
                    id: lijstDelegate
                    BorderImage {
                     id: item
                     width: parent.width ;
                     height: 15

                    Text {
                           id: tekstlijst
                           text: name + " >"
                        }
                   MouseArea {
                          id: mouse
                          anchors.fill: parent
                          hoverEnabled: true
                          onClicked: {
                              contactModel2.append({name: name})
                              //hier nog wijziging in de database doorvoeren
                           }
                     }
                }
                }
                ListView{
                        id: leftList
                        model: contactModel //deze lijst komt van de admin zelf (zijn forms)
                        delegate: lijstDelegate
                        height: first.height
                        anchors.fill: parent
                }
            }
            Rectangle {
                id: first_middle
                width: first.width/4.6
                color: "gray"
                anchors.left: first_left.right
                /*ColumnLayout{
                    Button{
                        id: add
                        text: ">"
                    }
                    Button{
                        id: remove
                        text: "<"
                    }
                }*/
            }
            Rectangle {
                id: first_right
                width: first.width/2.3
                anchors.left: first_middle.right
                height: first.height
                ListModel {
                    id: contactModel2
                    ListElement {
                        name: "Bill Smith"
                    }
                    ListElement {
                        name: "John Brown"
                    }
                    ListElement {
                        name: "Sam Wise"
                    }
                }
                Component{
                    id: lijstDelegate2
                    BorderImage {
                     id: item
                     width: parent.width ;
                     height: 15

                    Text {
                           id: tekstlijst
                           text: "< " +name
                        }
                   MouseArea {
                          id: mouse
                          anchors.fill: parent
                          hoverEnabled: true
                          onClicked: {
                              contactModel.append({name: name})
                              //hier nog wijziging in de database doorvoeren
                           }
                     }
                }
                }
                ListView{
                        model: contactModel2 //deze lijst komt van de user uit de tabel zelf (zijn forms)
                        delegate: lijstDelegate2
                    height: first.height
                    anchors.fill: parent
                }
            }
        }

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
            height: 50
            ColumnLayout {
                x: 10
                anchors.margins: 3
                spacing: 3

                TextField {
                    id: editlogin
                    Layout.fillWidth: true
                    placeholderText: "Username"
                }
                TextField {
                    id: edituserPassw
                    Layout.fillWidth: true
                    placeholderText: "Password"
                }
                TextField {
                    id: edituserFirstName
                    Layout.fillWidth: true
                    placeholderText: "First name"
                }

                TextField {
                    id: edituserLastName
                    Layout.fillWidth: true
                    placeholderText: "Last name"
                }

                TextField {
                    id: edituserEmail
                    Layout.fillWidth: true
                    placeholderText: "Email"
                }

                Button {
                    id: editproccessButton
                    Layout.fillWidth: true
                    text: "Edit User"

                    onClicked: {
                        var reply =
                                    { "id":client_id_edit,
                                      "username": editlogin.text,
                                      "password": edituserPassw.text,
                                      "email": edituserEmail.text,
                                      "firstName": edituserFirstName.text,
                                      "lastName": edituserLastName.text,
                                      "myAdmin" : settings.username
                                    };
                        //enginioClient.update(reply);
                        //enginioModelUsers.append(reply);
                                    enginioModelUsers.append({"id":client_id_edit,
                                                            "username": editlogin.text,
                                                            "password": edituserPassw.text,
                                                            "email": edituserEmail.text,
                                                            "firstName": edituserFirstName.text,
                                                            "lastName": edituserLastName.text,
                                                            "myAdmin" : settings.username}, Enginio.UserOperation)
                        getDataUsers();
                        //edit_userdata(editlogin.text,edituserFirstName.text,edituserLastName.text,edituserEmail.text)
                    }
                }

            }}
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
            text: "ADD"

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
                        getDataUsers();
                    })
            }
        }

    }
    }

    }

    function edit_userdata(username,firstname,lastname,email)
    {
        var output = {
            "id": client_id_edit,
             "username": username,
             "email": email,
             "firstName": firstname,
             "lastName": lastname,
             //"admin": null,
             //"myAdmin": null,
             //"forms": null
        }
        //functie voorzien om dit object weg te schrijven naar de database
    }

    function getDataUsers() {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"myAdmin\":\""+ settings.username +"\"}"
        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                tabelmodel.clear()
                for(var i = 0; i < arr1.length; i++) {
                tabelmodel.append({"id": arr1[i].id, "firstName":arr1[i].firstName,"lastName":arr1[i].lastName,"username":arr1[i].username,"email":arr1[i].email})
                    var arr2 = {};
                    arr2 = arr1[i].forms;
                    if(arr2.length > 0)
                    {
                    for(var z = 0; z < arr2.length;z++)
                    {
                        contactModel2.append({"name": arr2[z]})
                    }
                    }
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
