import QtQuick 2.0
import QtQuick.Layouts 1.1
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Styles 1.4

import "qrc:/FormResultFuntions.js" as Logic

Rectangle {
    id: rec_formbuilder
    width: parent.width
    height: parent.height

    property string aFormname: ""
    property string aFieldname: ""
    property int aIndexForm : 0;
    property variant indexFormArray: [];
    property variant newindexFormArray: [];
    property variant fullNameFormArray: [];
    property int aIndexFormSingle : 0;



    //test
    EnginioClient {
        id: client
        backendId: settings.myBackendId
        onError:
        {
         console.log("Enginio error: " + reply.errorCode + ": " + reply.errorString)
         //enginioModelErrors.append({"Error": "Enginio " + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
        }
    }

    EnginioModel {
        id: enginioModel
        client: client
        query: {
            "objectType": "objects.Form",
            "query" : { "User": settings.username, "FormName" : aFormname},
            "sort" : [ {"sortBy": "createdAt", "direction": "asc"} ]
        }
    }

    //FormName
    GridLayout {
        id: grid
        columns: 2
        columnSpacing: 10
        x:10
        y:10
        width: rec_formbuilder/7

        Button {
            id: textFieldbutton
            text: "Textfield"
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 70 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "TextField","req":"false"})
            }
        }
        Button{
            id: textAreabutton
            text: "Textarea"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":4,"heightItem": 170 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "TextArea","req":"false"})
            }
        }
        Button{
            id: comboboxbutton
            text: "Combobox"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 100 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "ComboBox","List":[],"req":"false"})
            }
        }
        Button{
            id: checkboxbutton
            text: "Checkbox"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":4,"heightItem": 200 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "CheckBox","List":[],"req":"false"})
            }
        }
        Button{
            id: fullNamebutton
            text: "Full Name"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Full Name", "Type" : "ComplexType","req":"false"})
            }
        }
        Button{
            id: emailbutton
            text: "Email"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Email", "Type" : "Email","req":"false"})
            }
        }
        Button{
            id: adressbutton
            text: "Adress"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":4,"heightItem": 250 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Adress", "Type" : "Adress","req":"false"})
            }
        }
        Button{
            id: numberbutton
            text: "Number"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "Number","req":"false"})
            }
        }
        Button{
            id: phonenumberbutton
            text: "Phone"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Phone", "Type" : "phone","req":"false"})
            }
        }
        Button{
            id: personebutton
            text: "Persone"
            enabled: false
            style: ButtonStyle {
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 50
                        color: "white"
                        border.width: control.activeFocus ? 2 : 1
                        border.color: "#39AEE6"
                        radius: 2
                        gradient: Gradient {
                            GradientStop { position: 0 ; color: control.pressed ? "white" : "white" }
                            GradientStop { position: 1 ; color: control.pressed ? "white" : "white" }
                        }
                    }
                }
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":4,"heightItem": 500 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Persone", "Type" : "Persone","req":"false"})
            }
        }
    }
    Rectangle{
        id:spacer
        width: 10
        height: parent.height
        anchors.left: grid.right
    }
    Rectangle{
        id:colorspacer
        width: 1
        color: "#39AEE6"
        height: parent.height
        anchors.left: spacer.right
    }

    Rectangle{
        width: rec_formbuilder.width - grid.width
        height: parent.height//rec_formbuilder.height - grid.height
        anchors.left: colorspacer.right

        color: "white"

        Rectangle {
            id: newform
            anchors.centerIn: parent
            width: 300
            height: 150
            color:"#1C353C"
            ColumnLayout{
                width: 200
                anchors.centerIn: parent
                Rectangle{
                    id:header
                    width: 200
                    height: 50
                    color:"#1C353C"
                    Text{
                        text: "New Form"
                        anchors.centerIn: parent
                        color: "white"
                        font.pixelSize: 20
                    }
                }

                TextField {
                    id: nameForm
                    width: 200
                    Layout.fillWidth: true
                    placeholderText: "New Form"
                }
                Component.onCompleted: getDataUserForms(settings.username)
                ComboBox{
                    id: comboboxForms
                    Layout.fillWidth: true
                    model: ListModel{
                        id: lijstmodel
                    }
                }

                Button {
                    id: startbutton
                    Layout.fillWidth: true
                    text: "Start"
                    onClicked: {
                        enableButtons()
                    }
                }
            }


        }

            Component {
                id: listDelegate
                Item {
                    id: item_list
                    width: 650 ;
                    height: heightItem + 40
                    Rectangle{
                        id: colorvalidator
                        width: 10
                        height: 70
                        x: 0
                        y: 10
                        color: "white"
                    }
                    Rectangle{
                        id: checkrect
                        width: 50
                        height: 70
                        color: "white"
                        anchors.left: colorvalidator.right

                        Image {
                            id: checkNameSaved
                            width: 30
                            height: 30
                            anchors.horizontalCenter: checkrect.horizontalCenter
                            anchors.verticalCenter: checkrect.verticalCenter
                            source: Name === "" ? "qrc:/new/prefix1/tick_red.png" : "qrc:/new/prefix1/tick_green.png"
                        }
                    }



                    Column{
                        id: col
                        anchors.left: checkrect.right
                        width: parent.width
                        x: 10;
                                spacing: 10
                                Rectangle {
                                    width: parent.width;
                                    height: 20;
                                    color: "white"
                                    x: 20

                                    TextField {
                                        id: name_component
                                        width: parent.width/2 ;
                                        text: Name
                                        placeholderText: Name == "" ? "Fill in the title here" : ""
                                    }
                                    Rectangle{
                                        id: horizontalSpacer
                                        width: 5
                                        height: 25
                                        anchors.left: name_component.right
                                    }

                                    Button
                                    {
                                        id: changeName
                                        height: 25
                                        width: 25
                                        anchors.left: horizontalSpacer.right
                                        enabled: name_component.length
                                        Image {
                                                anchors.fill: parent
                                                source: "qrc:/new/prefix1/pencil.png"
                                            }
                                        style: ButtonStyle {
                                                background: Rectangle {
                                                    implicitWidth: 25
                                                    implicitHeight: 25
                                                    color: "white"
                                                    border.width: 0
                                                    border.color: "transparent"
                                                    radius: 0
                                                    gradient: Gradient {
                                                        GradientStop { position: 0 ; color: control.pressed ? "transparent" : "transparent" }
                                                        GradientStop { position: 1 ; color: control.pressed ? "transparent" : "transparent" }
                                                    }
                                                }
                                            }
                                        onClicked:{
                                            enginioModel.setProperty(index, "Name", name_component.text);
                                        }
                                    }
                                    Rectangle{
                                        id: horizontalSpacer2
                                        width: 5
                                        height: 25
                                        anchors.left: changeName.right
                                    }
                                    Text{
                                        id: fieldname
                                        anchors.left: horizontalSpacer2.right
                                        text: Name === "" ? "no fieldname" : ""
                                        color: "white"
                                        y:5
                                        verticalAlignment : Text.AlignHCenter
                                    }
                                    CheckBox{
                                        id: checkReq
                                        y:5
                                        anchors.left: fieldname.right
                                        text: qsTr("required")
                                        checked: req
                                        onClicked: {
                                        enginioModel.setProperty(index, "req", !req);
                                        }
                                    }
                                }
                                 AdressComponent{
                                     visible: Type == "Adress"
                                 }

                                FullNameComponent{
                                    visible: Type == "ComplexType"
                                }

                                EmailComponent {
                                    visible: Type == "Email"
                                }

                                PhoneComponent{
                                    visible: Type == "phone"
                                }

                                TextFieldComponent{
                                    visible: Type == "TextField"
                                }

                                TextAreaComponent{
                                    visible: Type == "TextArea"
                                }
                                PersoneComponent{
                                    visible: Type == "Persone"
                                }


                    /*
                        Checkbox nog niet werkend. Een listview nog aan koppelen om meerdere weer te geven.
                        Idem maken voor radiobuttons
                    */

                                Rectangle {
                                    width: parent.width;
                                    color: "white"
                                    height: 150
                                    id: item4
                                    visible: Type == "CheckBox"
                                    x: 20
                                    Row {
                                        id: rowcheckbox
                                        TextField{
                                            id: inputcheckbox
                                            width: Screen.width/5
                                        }
                                        Rectangle{
                                            id: checkboxspacer
                                            width: 10
                                            height: 20
                                        }
                                        Button{
                                            id: addcheckbox
                                            text: "add"
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
                                                var url = "https://api.engin.io/v1/objects/Form/"+ containerID.text +"/atomic";
                                                var xhr = new XMLHttpRequest();
                                                       xhr.onreadystatechange = function() {
                                                           if ( xhr.readyState == xhr.DONE)
                                                           {
                                                               console.log("Success " + xhr.responseText + " STATUS " + xhr.status)
                                                               if ( xhr.status == 200)
                                                               {
                                                                   var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                                                                   console.log("Success " + jsonObject.balance)
                                                                   inputcheckbox.text = "";
                                                                   reload()
                                                               }
                                                           }
                                                       }
                                                       xhr.open("PUT",url,true);
                                                       var data = {
                                                            "$push": {
                                                            "List": inputcheckbox.text
                                                        }
                                                       }
                                                       xhr.setRequestHeader("Enginio-Backend-Id", "54be545ae5bde551410243c3")
                                                xhr.send(JSON.stringify(data));
                                            }
                                        }
                                    }
                                    Rectangle{
                                        id: spacer
                                        height: 10
                                        width: 180
                                        anchors.top: rowcheckbox.bottom
                                    }

                                    ScrollView {
                                        anchors.top: spacer.bottom
                                        width: 300;
                                        height: 150

                                    Column{
                                        id: columnCheckbox
                                        spacing: 20
                                        width: parent.width


                                    Repeater {
                                            id: rep
                                            model: List
                                            Row{
                                                spacing: 20
                                                width: 300

                                            CheckBox {
                                                height: 15
                                                id: checkbox_item
                                                text: modelData
                                                y:5
                                            }


                                            Button{
                                                id: removecheckbox
                                                width: 50

                                                    style: ButtonStyle {
                                                            background: Rectangle {
                                                                implicitWidth: 25
                                                                implicitHeight: 25
                                                                color: "white"
                                                                border.width: 0
                                                                border.color: "transparent"
                                                                radius: 0
                                                                gradient: Gradient {
                                                                    GradientStop { position: 0 ; color: control.pressed ? "transparent" : "transparent" }
                                                                    GradientStop { position: 1 ; color: control.pressed ? "transparent" : "transparent" }
                                                                }
                                                            }
                                                        }
                                                    iconSource: "qrc:/new/prefix1/Delete.png"
                                                    onClicked: {
                                                    var url = "https://api.engin.io/v1/objects/Form/"+ containerID.text +"/atomic";
                                                    var xhr = new XMLHttpRequest();
                                                           xhr.onreadystatechange = function() {
                                                               if ( xhr.readyState == xhr.DONE)
                                                               {
                                                                   console.log("Success " + xhr.responseText + " STATUS " + xhr.status)
                                                                   if ( xhr.status == 200)
                                                                   {
                                                                       var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                                                                       console.log("Success " + jsonObject.balance)
                                                                        reload()
                                                                   }
                                                               }
                                                           }
                                                           xhr.open('PUT',url,true);
                                                           var data = {
                                                                 "$pull": {
                                                                "List": modelData
                                                            }
                                                           }
                                                           xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
                                                    xhr.send(JSON.stringify(data));
                                                }
                                            }

                                            }
                                    }
                                    }
                                }

                                }
                                //COMBOBOX
                                Rectangle {
                                    height: 30
                                    width: parent.width - 50
                                    id: item3
                                    visible: qsTr(Type) === "ComboBox"
                                    x: 20
                                    color: "white"
                                Text{
                                    id: containerID
                                    text: id
                                    visible: false
                                }
                                ComboBox {
                                    height: 25
                                    id: combobox_item
                                    width: parent.width/5
                                    model: List
                                }
                                TextField {
                                    id: inputComboBox
                                    width: Screen.width/5
                                    anchors.left: combobox_item.right
                                }

                                Button {
                                           id: addIcon
                                           text: "add"
                                           anchors.margins: 20
                                           anchors.left: inputComboBox.right
                                           enabled: inputComboBox.text.length
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
                                               var url = "https://api.engin.io/v1/objects/Form/"+ containerID.text +"/atomic";
                                               var xhr = new XMLHttpRequest();
                                                      xhr.onreadystatechange = function() {
                                                          if ( xhr.readyState == xhr.DONE)
                                                          {
                                                              console.log("Success " + xhr.responseText + " STATUS " + xhr.status)
                                                              if ( xhr.status == 200)
                                                              {
                                                                  var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                                                                  console.log("Success " + jsonObject.balance)
                                                                  inputComboBox.text = "";
                                                                  reload()
                                                              }
                                                          }
                                                      }
                                                      xhr.open("PUT",url,true);
                                                      var data = {
                                                           "$push": {
                                                           "List": inputComboBox.text
                                                       }
                                                      }
                                                      xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
                                               xhr.send(JSON.stringify(data));
                                           }
                                        }
                                Button {
                                           id: removeButton
                                           text: "remove current"
                                           anchors.margins: 20
                                           anchors.left: addIcon.right
                                           style: ButtonStyle {
                                                   background: Rectangle {
                                                       implicitWidth: 100
                                                       implicitHeight: 25
                                                       color: "white"
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
                                               var url = "https://api.engin.io/v1/objects/Form/"+ containerID.text +"/atomic";
                                               var xhr = new XMLHttpRequest();
                                                      xhr.onreadystatechange = function() {
                                                          if ( xhr.readyState == xhr.DONE)
                                                          {
                                                              console.log("Success " + xhr.responseText + " STATUS " + xhr.status)
                                                              if ( xhr.status == 200)
                                                              {
                                                                  var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                                                                  console.log("Success " + jsonObject.balance)
                                                                   reload()
                                                              }
                                                          }
                                                      }
                                                      xhr.open('PUT',url,true);
                                                      var data = {
                                                            "$pull": {
                                                           "List": combobox_item.currentText
                                                       }
                                                      }
                                                      xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
                                               xhr.send(JSON.stringify(data));
                                           }
                                        }

                                }

                                Rectangle {
                                                height: 1
                                                width: parent.width
                                                color: "white"
                                            }

                    }
                    Rectangle{
                        anchors.left: col.right
                        width: 50
                        height: 50
                        color:"white"
                        Button{
                            id: deleteButton
                            anchors.bottom: parent.bottom
                            style: ButtonStyle {
                                    background: Rectangle {
                                        implicitWidth: 25
                                        implicitHeight: 25
                                        color: "white"
                                        border.width: 0
                                        border.color: "transparent"
                                        radius: 0
                                        gradient: Gradient {
                                            GradientStop { position: 0 ; color: control.pressed ? "transparent" : "transparent" }
                                            GradientStop { position: 1 ; color: control.pressed ? "transparent" : "transparent" }
                                        }
                                    }
                                }
                            anchors.right: parent.right
                            iconSource: "qrc:/new/prefix1/Delete.png"
                            onClicked: {
                                enginioModel.remove(index);
                                pop_indexFormArrayRegulator(indexForm);
                            }
                        }
                    }
                }
            }

                ListView {
                    id: formListView
                    model: enginioModel
                    delegate: listDelegate
                    clip: true
                    anchors.left: grid.right
                    y: 50
                    visible: false
                    width: rec_formbuilder.width - grid.width
                    height: parent.height - 100

                    // Animations
                    add: Transition { NumberAnimation { properties: "y"; from: root.height; duration: 250 } }
                    removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 150 } }
                    remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 150 } }

                    anchors.top: actionbar.bottom
                }

                Rectangle{
                    id: actionbar
                    color: "#E8ECEE"
                    width: rec_formbuilder.width - grid.width
                    height: 50
                    y:0
                    visible: true;
                    Row{
                        id: rowActionbar
                        height :49
                        anchors.centerIn: parent
                        width: rec_formbuilder.width - grid.width
                        spacing: 20;
                        Text{
                            id: formheader
                            text:"My Form"
                            anchors.centerIn: parent
                        }

                     /*Button{
                         id: swapBUtton
                         anchors.verticalCenter: rowActionbar.verticalCenter
                         text: "SWAP";
                         width: 50;
                         height: 20;
                         visible: false
                         onClicked: {
                             swap2();
                         }
                     }
                     Button{
                         id: reloadBUtton
                         anchors.verticalCenter: rowActionbar.verticalCenter
                         text: "Reload";
                         width: 50;
                         height: 20;
                         visible: false
                         onClicked: {
                             reload();
                         }
                     }*/
                    }
                    Rectangle{
                        id: linespacer
                        height: 1
                        width: rec_formbuilder.width - grid.width
                        color:"gray"
                        anchors.top: rowActionbar.bottom
                    }
                }

    }
    function enableButtons()
    {
        if(nameForm.text != "")
        {
            aFormname = nameForm.text;
            checkIfFormExcists()
        }
        else{
            aFormname = comboboxForms.currentText
        }
        textFieldbutton.enabled = true;
        textAreabutton.enabled = true;
        comboboxbutton.enabled = true;
        checkboxbutton.enabled = true;
        formListView.visible = true;
        newform.visible = false;
        actionbar.visible = true;
        fullNamebutton.enabled = true;
        adressbutton.enabled = true;
        emailbutton.enabled = true;
        phonenumberbutton.enabled = true;
        personebutton.enabled = true;
    }
    function checkIfFormExcists()
    {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.engin.io/v1/users?q={\"username\":\""+ settings.username +"\"}&limit=1"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var arr = JSON.parse(xmlhttp.responseText);
                var arr1 = arr.results;
                for(var i = 0; i < arr1.length; i++) {
                    console.log(arr1[i].forms);
                    for(var y = 0; y < arr1[i].forms.length; y++)
                    {
                        if(aFormname == arr1[i].forms[y])
                        {
                            console.log("CONTROLE 2: DE "+ aFormname +" BESTAAT")
                            return true;
                        }
                    }
                }
                console.log("CONTROLE 2: DE "+ aFormname +" BESTAAT NIET")
                addFormToUser();
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
    function reload() {
        var a = enginioModel.query
        enginioModel.query = null
        enginioModel.query = a
    }


    function indexRegulator()
    {
        aIndexForm = aIndexForm + 1;
    }

    function push_indexFormArrayRegulator(index,i)
    {
        var a = {"index": index, "indexForm":i};
        indexFormArray.push(a);
        if(indexFormArray.length == 2)
        {
            swapBUtton.visible = true;
            reloadBUtton.visible = true;
        }
        else
        {
            swapBUtton.visible = false;
            reloadBUtton.visible = false;
        }
    }

    //bron: http://stackoverflow.com/questions/10024866/remove-object-from-array-using-javascript

    function pop_indexFormArrayRegulator(z)
    {
        for (var i =0; i < indexFormArray.length; i++)
           if (indexFormArray[i].indexForm === z) {
              indexFormArray.splice(i,1);
              break;
           }
        if(indexFormArray.length == 2)
        {
            swapBUtton.visible = true;
            reloadBUtton.visible = true;
        }
        else
        {
            swapBUtton.visible = false;
            reloadBUtton.visible = false;
        }
    }


    function swap()
    {

        enginioModel.setProperty(indexFormArray[0].index, "indexForm", indexFormArray[1].indexForm);
        enginioModel.setProperty(indexFormArray[1].index, "indexForm", indexFormArray[0].indexForm);
        return true;
    }
    function swap2()
    {

        if(swap()===true)
        {
            reload();
            indexFormArray.length = 0;// = newindexFormArray;
        }
    }

   //bron : http://stackoverflow.com/questions/105034/create-guid-uuid-in-javascript

    function createSessionID()
    {
      var lut = [];
      for (var i=0; i<256; i++) { lut[i] = (i<16?'0':'')+(i).toString(16); }

      var d0 = Math.random()*0xffffffff|0;
      var d1 = Math.random()*0xffffffff|0;
      var d2 = Math.random()*0xffffffff|0;
      var d3 = Math.random()*0xffffffff|0;
      console.log(lut[d0&0xff]+lut[d0>>8&0xff]+lut[d0>>16&0xff]+lut[d0>>24&0xff]+'-'+
        lut[d1&0xff]+lut[d1>>8&0xff]+'-'+lut[d1>>16&0x0f|0x40]+lut[d1>>24&0xff]+'-'+
        lut[d2&0x3f|0x80]+lut[d2>>8&0xff]+'-'+lut[d2>>16&0xff]+lut[d2>>24&0xff]+
        lut[d3&0xff]+lut[d3>>8&0xff]+lut[d3>>16&0xff]+lut[d3>>24&0xff]);
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

    function addFormToUser()
    {
        var url = "https://api.engin.io/v1/users/"+ settings.my_id +"/atomic";
        var xhr = new XMLHttpRequest();
               xhr.onreadystatechange = function() {
                   if ( xhr.readyState == xhr.DONE)
                   {
                       console.log("Success " + xhr.responseText + " STATUS " + xhr.status)
                       if ( xhr.status == 200)
                       {
                           var jsonObject = JSON.parse(xhr.responseText); // Parse Json Response from http request
                           console.log("Success " + jsonObject.balance)
                           inputComboBox.text = "";
                           reload()
                       }
                   }
               }
               xhr.open("PUT",url,true);
               var data = {
                    "$push": {
                    "forms": aFormname
                }
               }
               xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
        xhr.send(JSON.stringify(data));
    }
}

