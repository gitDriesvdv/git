import QtQuick 2.0
import Enginio 1.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
import Qt.labs.settings 1.0

Rectangle{
    anchors.fill: parent
    property string client_id_edit: ""
    property string currentFormnale: ""
    property string currentUsername: ""
    Component.onCompleted: {
        getDataUsers();
    }

    EnginioClient {
        id: enginioClient
        backendId: settings.myBackendId
        onError: {
        console.debug(JSON.stringify(reply.data))
        }
    }

    EnginioModel {
        id: enginioModelListForms
        client: enginioClient
    }

    EnginioModel {
        id: enginioModelUsers
        client: enginioClient
        operation: Enginio.UserOperation
        query: {"objectType": "users" }
    }
    Rectangle{
        id: header
        height: 50
        width: parent.width
        Text{
            id: titel
            x:30
            y:20
            text:"My Users"
            font.pixelSize: 20
            color: "gray"
        }
    }

    //BOVENSTE DEEL MET DE TABEL EN DE KNOPPEN
    Row {
        id: topRij
        anchors.margins: 3
        anchors.top: header.bottom
        spacing: 3
        height: Screen.height/2.5
        width: Screen.width
        x: 30

        Rectangle{
        id: left
        height: Screen.height/2.5
        width: Screen.width/1.3
        TableView {
            id: tabel
            Layout.fillWidth: true
            Layout.fillHeight: true
            height: Screen.height/2.5
            width: Screen.width/1.3
            style: TableViewStyle{
                alternateBackgroundColor :"white"
            }
           onClicked: {
               if(tabel.model.get(row).username != settings.username)
               {
                   deleteButton.enabled = true
               }
               else
               {
                   deleteButton.enabled = false
               }
               client_id_edit = tabel.model.get(row).id
               editlogin.text = tabel.model.get(row).username
               edituserEmail.text = tabel.model.get(row).email
               edituserFirstName.text = tabel.model.get(row).firstName
               edituserLastName.text = tabel.model.get(row).lastName

               currentUsername = tabel.model.get(row).username;
               getSelectedDataUserForms(tabel.model.get(row).username);
           }

            TableViewColumn { title: "Id"; role: "id" }
            TableViewColumn { title: "First name"; role: "firstName" }
            TableViewColumn { title: "Last name"; role: "lastName" }
            TableViewColumn { title: "Login"; role: "username" }
            TableViewColumn { title: "Email"; role: "email" }

            model: ListModel {
                id: tabelmodel
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
                        border.color: "#4BB43A"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "#4BB43A" : "#4BB43A" }
                            GradientStop { position: 1 ; color: control.pressed ? "#4BB43A" : "#4BB43A" }
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
                        color: "black"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "red"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "red" : "red" }
                            GradientStop { position: 1 ; color: control.pressed ? "red" : "red" }
                        }
                    }
                }
            onClicked: {
                tabelmodel.remove(tabel.currentRow);
            }
        }
      }
    }
}

    //ONDERSTE DEEL MET DE INVOERVELDEN
    Row {
        anchors.top: topRij.bottom
        width: Screen.width
        x: 30
        Rectangle {
            id: first
            anchors.left: parent.left
            color: "white";
            width: parent.width/4;
            height: 200
            Rectangle{
                id: headerForms
                height: 40
                width: first.width
                Text{
                    text: "Forms"
                    anchors.centerIn: parent
                    color: "gray"
                    font.pixelSize: 20
                }
            }
            RowLayout{
                anchors.top: headerForms.bottom
                height: first.height - 40

            Rectangle{
                id: first_left
                width: first.width/2.3
                height: first.height - 40
                anchors.top: headerForms.bottom

                ListModel {
                    id: adminFomModel

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
                          anchors.fill: tekstlijst
                          hoverEnabled: true
                          onClicked: {
                              checkIfFormExcists(currentUsername,name,client_id_edit)
                           }
                     }
                }
                }
                Rectangle{
                    anchors.top: parent.top
                    height: 20
                    width: first_left.width
                    id: adminForms

                    Text {
                        text: qsTr("Adminforms")
                        height: 20
                        horizontalAlignment: Text.AlignHCenter
                        width: first_left.width
                        font.underline : true
                    }
                }
                ListView {
                        id: leftList
                        model: adminFomModel //deze lijst komt van de admin zelf (zijn forms)
                        delegate: lijstDelegate
                        height: first.height - 40
                        anchors.top: adminForms.bottom
                        Component.onCompleted: getDataUserForms();
                }
            }
            Rectangle {
                id: first_middle
                width: 2
                color: "gray"
                anchors.left: first_left.right
            }
            Rectangle {
                id: first_right
                width: first.width/2.3
                anchors.left: first_middle.right
                height: first.height - 40
                ListModel {
                    id: selectedUserFomModel
                }
                Component{
                    id: lijstDelegate2
                    BorderImage {
                     id: item
                     width: parent.width ;
                     height: 15

                    Text {
                           id: tekstlijst
                           text: "< " + name
                        }
                   MouseArea {
                          id: mouse
                          anchors.fill: tekstlijst
                          hoverEnabled: true
                          onClicked: {
                              removeFormToUser(client_id_edit,currentUsername,name)
                           }
                     }
                }
                }

                Rectangle{
                    anchors.top: parent.top
                    height: 20
                    width: first_right.width
                    id: userForms

                    Text {
                        text: qsTr("Userforms")
                        height: 20
                        horizontalAlignment: Text.AlignHCenter
                        width: first_right.width
                          font.underline : true
                    }
                }

                ListView{
                    model: selectedUserFomModel //deze lijst komt van de user uit de tabel zelf (zijn forms)
                    delegate: lijstDelegate2
                    anchors.top: userForms.bottom
                    height: first.height - 40
                }
            }
            }
        }

        Rectangle{
            id: spacer
            width: 2
            y:10
            color: "#1A3138"
            height: 200
            anchors.left: first.right
        }

        Rectangle {
            id: second
            anchors.left: spacer.right
            color: "white";
            width: parent.width/4;
            height: 50

      //Editeren van een gebruiker
            ColumnLayout {
                x: 50
                anchors.margins: 3
                spacing: 3
                Rectangle{
                    id: headerEditUser
                    height: 40
                    width: second.width/1.5
                    Text{
                        text: "Edit User"
                        anchors.centerIn: parent
                        color: "gray"
                        font.pixelSize: 20
                    }
                }
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
                        /*var reply =
                                    { "id":client_id_edit,
                                      "username": editlogin.text,
                                      "password": edituserPassw.text,
                                      "email": edituserEmail.text,
                                      "firstName": edituserFirstName.text,
                                      "lastName": edituserLastName.text,
                                      "myAdmin" : settings.username
                                    };*/
                        //enginioClient.update(reply);
                        //enginioModelUsers.append(reply);
                                    enginioModelUsers.append({"id":client_id_edit,
                                                            "username": editlogin.text,
                                                            "password": edituserPassw.text,
                                                            "email": edituserEmail.text,
                                                            "firstName": edituserFirstName.text,
                                                            "lastName": edituserLastName.text,
                                                            "admin":false,
                                                            "myAdmin" : settings.username}, Enginio.UserOperation)
                        getDataUsers();
                        //edit_userdata(editlogin.text,edituserFirstName.text,edituserLastName.text,edituserEmail.text)
                    }
                }

            }}
        Rectangle{
            id: spacer2
            width: 2
            y:10
            color: "#1A3138"
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

    //Toevoegen van een nieuwe gebruiker
    ColumnLayout {
        x: 50
        anchors.margins: 3
        spacing: 3
        Rectangle{
            id: headerNewUser
            height: 40
            width: second.width/1.5
            Text{
                text: "New User"
                anchors.centerIn: parent
                color: "gray"
                font.pixelSize: 20
            }
        }
        TextField {
            id: login
            Layout.fillWidth: true
            placeholderText: "Username"
            width: 30
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
                var reply = enginioClient.create(
                            { "username": login.text,
                              "password": password.text,
                              "email": userEmail.text,
                              "firstName": userFirstName.text,
                              "lastName": userLastName.text,
                              "admin":false,
                              "myAdmin" : settings.username
                            }, Enginio.UserOperation)

                reply.finished.connect(function() {

                        proccessButton.state = ""
                        if (reply.errorType !== EnginioReply.NoError) {
                            messageDialog.text = "Failed to create an account:\n" + JSON.stringify(reply.data, undefined, 2) + "\n\n"
                        } else {
                            messageDialog.text = "Account Created.\n"
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

    function getDataUserForms() {
        adminFomModel.clear();
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"username\":\""+ settings.username +"\"}&limit=1"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                for(var i = 0; i < arr1.length; i++) {
                    for(var y = 0; y < arr1[i].forms.length; y++)
                    {
                        adminFomModel.append({name: arr1[i].forms[y]})
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

    function getSelectedDataUserForms(username) {
        getDataUserForms();
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"username\":\""+ username +"\"}&limit=1"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                for(var i = 0; i < arr1.length; i++) {
                    selectedUserFomModel.clear();
                    for(var y = 0; y < arr1[i].forms.length; y++)
                    {
                        selectedUserFomModel.append({name: arr1[i].forms[y]})
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

    function checkIfFormExcists(username,formname,id)
    {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"username\":\""+ username +"\"}&limit=1"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                for(var i = 0; i < arr1.length; i++) {
                    for(var y = 0; y < arr1[i].forms.length; y++)
                    {
                        if(formname === arr1[i].forms[y])
                        {
                            return true;
                        }
                    }
                }
                addFormToUser(id,username,formname);
                return false;
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

    function addFormToUser(id,username,formname)
    {
        var url = "https://api.engin.io/v1/users/"+ id +"/atomic";
        var xhr = new XMLHttpRequest();
               xhr.onreadystatechange = function() {
                   if ( xhr.readyState == xhr.DONE)
                   {
                       if ( xhr.status == 200)
                       {
                           var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                           getSelectedDataUserForms(username)
                       }
                   }
               }
               xhr.open("PUT",url,true);
               var data = {
                    "$push": {
                    "forms": formname
                }
               }
               xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
        xhr.send(JSON.stringify(data));
    }

    function removeFormToUser(id,username,formname)
    {
        var url = "https://api.engin.io/v1/users/"+ id +"/atomic";
        var xhr = new XMLHttpRequest();
               xhr.onreadystatechange = function() {
                   if ( xhr.readyState == xhr.DONE)
                   {
                       if ( xhr.status == 200)
                       {
                           var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                           getSelectedDataUserForms(username)
                       }
                   }
               }
               xhr.open("PUT",url,true);
               var data = {
                    "$pop": {
                    "forms": formname
                }
               }
               xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
        xhr.send(JSON.stringify(data));
    }
}
