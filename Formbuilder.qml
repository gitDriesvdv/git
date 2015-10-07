import QtQuick 2.0
import QtQuick.Layouts 1.1
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0

Rectangle {
    width: Screen.width
    height: Screen.height

     property string aFormname: ""

    EnginioClient {
        id: client
        backendId: "54be545ae5bde551410243c3"
        onError:
        {
         console.log("Enginio error: " + reply.errorCode + ": " + reply.errorString)
         enginioModelErrors.append({"Error": "Enginio " + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
        }
    }

    EnginioModel {
        id: enginioModel
        client: client
        query: {
            "objectType": "objects.Form",
            "query" : { "User": "Dries", "FormName" : aFormname}
        }
    }

    //FormName

    GridLayout {
        id: grid
        columns: 2
        columnSpacing: 40

        Button{
            id: textFieldbutton
            text: "Textfield"
            enabled: false
            onClicked: {
                enginioModel.append({"FormName":aFormname,"User": "Dries", "Name": "Blanck", "Type" : "TextField"})
            }
        }
        Button{
            id: textAreabutton
            text: "Textarea"
            enabled: false
            onClicked: {
                enginioModel.append({"FormName":aFormname,"User": "Dries", "Name": "Blanck", "Type" : "TextArea"})
            }
        }
        Button{
            id: comboboxbutton
            text: "Combobox"
            enabled: false
            onClicked: {
                enginioModel.append({"FormName":aFormname,"User": "Dries", "Name": "Blanck", "Type" : "ComboBox"})
            }
        }
        Button{
            id: checkboxbutton
            text: "Checkbox"
            enabled: false
            onClicked: {
                enginioModel.append({"FormName":aFormname,"User": "Dries", "Name": "Blanck", "Type" : "CheckBox"})
            }
        }
    }
    Rectangle{
        //anchors.fill: parent
        width: Screen.width - grid.width
        height: Screen.height - grid.height
        anchors.left: grid.right
        color: "gray"

        Rectangle {
            id: newform
            anchors.centerIn: parent
            TextField {
                id: nameForm
                Layout.fillWidth: true
                placeholderText: "Username"
            }
            Button {
                id: startbutton
                text: "Start"
                onClicked: {
                    enableButtons()
                }
                anchors.top: nameForm.bottom
            }
        }

            Component {
                id: listDelegate
                Item {
                    id: item_list
                    width: 600 ;
                    height: 70
                    Column{
                        id: col
                        width: parent.width
                        x: 10;
                        y: 10

                                spacing: 10
                                Rectangle {
                                    width: parent.width;
                                    height: 20;
                                    color: "gray"
                                    x: 20
                                    TextField {
                                        id: name_component

                                        width: parent.width/2 ;
                                        text: Name
                                    }
                                    Button{
                                        id: changeName
                                        width: parent.width/5
                                        anchors.left: name_component.right
                                        text: "Change name"
                                    }
                                }
                                Rectangle {
                                    id: item1
                                    visible: Type == "TextField"
                                    x: 20
                                    y: 20
                                    width: parent.width;
                                    height: 20;
                                    color: "gray"
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width;
                                    id: textfield_item

                                }
                                }

                                Rectangle {
                                    width: parent.width;
                                    color: "gray"
                                    height: 75
                                    id: item2
                                    visible: Type == "TextArea"
                                    x: 20
                                    y: 10
                                TextArea {
                                    height: 75
                                    font.pixelSize: 15
                                    id: textarea_item
                                    Component.onCompleted: {
                                        item_list.height = 160
                                        }
                                }
                                }
                    /*
                        Checkbox nog niet werkend. Een listview nog aan koppelen om meerdere weer te geven.
                        Idem maken voor radiobuttons
                    */

                                Flickable {
                                    width: parent.width;
                                    //color: "gray"
                                    height: 150
                                    id: item4
                                    visible: Type == "CheckBox"
                                    x: 20
                                    y: 10
                                    Column{
                                        spacing: 2
                                       // height: 20
                                        width: parent.width
                                        Row{
                                            TextField{
                                                id: inputcheckbox
                                                width: Screen.width/5
                                            }
                                            Button{
                                                id: addcheckbox
                                                text: "add"
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


                                    Repeater {
                                            id: rep
                                            model: List
                                            Row{
                                                spacing: 10
                                            CheckBox {
                                                height: 15
                                                id: checkbox_item
                                                text: modelData

                                            }
                                            Button{
                                                id: removecheckbox
                                                text: "remove"
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
                                                           xhr.setRequestHeader("Enginio-Backend-Id", "54be545ae5bde551410243c3")
                                                    xhr.send(JSON.stringify(data));
                                                }
                                            }

                                            }


                                    }
                                    }

                                }
                                Rectangle {
                                    height: 30
                                    width: parent.width
                                    id: item3
                                    visible: Type == "ComboBox"
                                    x: 20
                                    color: "gray"
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
                                TextField{
                                    id: inputComboBox
                                    width: Screen.width/5
                                    anchors.left: combobox_item.right
                                }

                                Button {
                                           id: addIcon
                                           text: "ADD"
                                           anchors.margins: 20
                                           anchors.left: inputComboBox.right
                                           enabled: inputComboBox.text.length
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
                                                      xhr.setRequestHeader("Enginio-Backend-Id", "54be545ae5bde551410243c3")
                                               xhr.send(JSON.stringify(data));

                                           }
                                        }
                                Button {
                                           id: removeButton
                                           text: "Remove current"
                                           anchors.margins: 20
                                           anchors.left: addIcon.right
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
                                                      xhr.setRequestHeader("Enginio-Backend-Id", "54be545ae5bde551410243c3")
                                               xhr.send(JSON.stringify(data));
                                           }
                                        }

                                }
                                Rectangle {
                                    width: parent.width;
                                    color: "gray"
                                    height: 25
                                    id: delete_button
                                    x: 20
                                    y: 20
                                    Button {
                                               id: removeIcon
                                               text: "remove"
                                               anchors.margins: 20
                                               opacity: enabled ? 1 : 0.5
                                               Behavior on opacity {NumberAnimation{duration: 100}}
                                               onClicked: enginioModel.remove(index)
                                            }
                                }
                                Rectangle {
                                                height: 1
                                                width: parent.width
                                                color: "white"
                                            }

                    }
                }
            }

                ListView {
                    id: formListView
                    //interactive: false
                    model: enginioModel
                    delegate: listDelegate
                    clip: true
                     anchors.left: grid.right
                     y: 50
                    //width: parent.width
                    //height: parent.height
                    visible: false
                    width: Screen.width - grid.width
                    height: parent.height - 100//Screen.height - grid.height

                    // Animations
                    add: Transition { NumberAnimation { properties: "y"; from: root.height; duration: 250 } }
                    removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 150 } }
                    remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 150 } }
                }
    }
    function enableButtons()
    {
        aFormname = nameForm.text;
        textFieldbutton.enabled = true;
        textAreabutton.enabled = true;
        comboboxbutton.enabled = true;
        checkboxbutton.enabled = true;
        formListView.visible = true;
        newform.visible = false;
    }
    function reload() {
        var a = enginioModel.query
        enginioModel.query = null
        enginioModel.query = a
    }
}

