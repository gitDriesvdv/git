import QtQuick 2.0
import QtQuick.Layouts 1.1
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

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
        backendId: "54be545ae5bde551410243c3"
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
            "query" : { "User": "Dries", "FormName" : aFormname},
            "sort" : [ {"sortBy": "indexForm", "direction": "asc"} ]
        }
    }

    //FormName

    GridLayout {
        id: grid
        columns: 2
        columnSpacing: 40
        width: rec_formbuilder/7

        Button {
            id: textFieldbutton
            text: "Textfield"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 70 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": aFieldname, "Type" : "TextField","req":"false"})
            }
        }
        Button{
            id: textAreabutton
            text: "Textarea"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":4,"heightItem": 170 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": aFieldname, "Type" : "TextArea"})
            }
        }
        Button{
            id: comboboxbutton
            text: "Combobox"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 100 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": aFieldname, "Type" : "ComboBox","List":[]})
            }
        }
        Button{
            id: checkboxbutton
            text: "Checkbox"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":4,"heightItem": 200 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": aFieldname, "Type" : "CheckBox","List":[]})
            }
        }
        Button{
            id: fullNamebutton
            text: "Full Name"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": "Full Name", "Type" : "ComplexType"})
            }
        }
        Button{
            id: emailbutton
            text: "Email"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": "Email", "Type" : "Email"})
            }
        }
        Button{
            id: adressbutton
            text: "Adress"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":4,"heightItem": 250 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": "Adress", "Type" : "Adress"})
            }
        }

        Button{
            id: phonebutton
            text: "Phone"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": "Phone", "Type" : "Phone"})
            }
        }

        Button{
            id: numberbutton
            text: "Number"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": "Dries", "Name": aFieldname, "Type" : "Number"})
            }
        }

    }
    Rectangle{
        width: rec_formbuilder.width - grid.width
        height: rec_formbuilder.height - grid.height
        anchors.left: grid.right
        color: "gray"

        Rectangle {
            id: newform
            anchors.centerIn: parent
            TextField {
                id: nameForm
                Layout.fillWidth: true
                placeholderText: "Formname"
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
                    height: heightItem + 40
                    Rectangle{
                        id: colorvalidator
                        width: 10
                        height: 70
                        x: 0
                        y: 10
                        color: Name === "" ? "red" : "green"
                    }
                    Rectangle{
                        id: checkrect
                        width: 50
                        height: 70
                        color: "gray"
                        //y: 10
                        anchors.left: colorvalidator.right
                        CheckBox {
                                id: fielcheck
                                anchors.horizontalCenter: checkrect.horizontalCenter
                                anchors.verticalCenter: checkrect.verticalCenter
                                //text: qsTr(test)
                                //checked: true

                                onClicked:  {
                                    if(fielcheck.checked)
                                    {
                                        push_indexFormArrayRegulator(index,indexForm);
                                    }
                                    else
                                    {
                                        pop_indexFormArrayRegulator(indexForm);
                                    }
                                }
                            }
                    }



                    Column{
                        id: col
                        anchors.left: checkrect.right
                        width: parent.width
                        x: 10;
                        //y: 10

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
                                        text: "Save name"
                                        enabled: name_component.length
                                        onClicked:{
                                            enginioModel.setProperty(index, "Name", name_component.text);
                                        }
                                    }
                                    Text{
                                        id: fieldname
                                        anchors.left: changeName.right
                                        text: Name === "" ? "no fieldname" : ""
                                        color: "white"
                                        verticalAlignment : Text.AlignHCenter
                                    }
                                    CheckBox{
                                        id: checkReq
                                        anchors.left: fieldname.right
                                        text: qsTr("required")
                                        checked: req
                                        onClicked: {
                                        enginioModel.setProperty(index, "req", !req);
                                        }
                                    }
                                }

                                Rectangle {
                                    id: itemAdress
                                    visible: Type == "Adress"
                                    x: 20
                                    width: parent.width;
                                    height: 150;
                                    color: "gray"

                                    //straat + nummer
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width;
                                    id: textfield_street

                                }
                                Text{
                                    id: text_streetname
                                    height: 20
                                    text:qsTr("streetname + number")
                                    width: parent.width/2.5;
                                    anchors.top: textfield_street.bottom
                                    color: "white"
                                }

                                //plaats
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_place
                                    anchors.top: text_streetname.bottom
                                }
                                Text{
                                    id: text_place
                                    height: 20
                                    text:qsTr("place")
                                    width: parent.width/2.5;
                                    anchors.top: textfield_place.bottom
                                    color: "white"
                                }

                                //staat
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_state
                                    anchors.top: text_streetname.bottom
                                    anchors.left: textfield_place.right

                                }
                                Text{
                                    id: text_state
                                    height: 20
                                    text:qsTr("State")
                                    anchors.top: textfield_state.bottom
                                    anchors.left: text_place.right
                                    color: "white"
                                }

                                //postcode
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_postcode
                                    anchors.top: text_state.bottom

                                }
                                Text{
                                    id: text_postcode
                                    height: 20
                                    width: parent.width/2.5;
                                    text:qsTr("zip code")
                                    anchors.top: textfield_postcode.bottom
                                    color: "white"
                                }

                                //land
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_country
                                    anchors.top: text_state.bottom
                                    anchors.left: textfield_postcode.right

                                }
                                Text{
                                    id: text_country
                                    height: 20
                                    text:qsTr("country")
                                    anchors.top: textfield_country.bottom
                                    anchors.left: text_postcode.right
                                    color: "white"
                                }
                                }
                                Rectangle {
                                    id: itemFullName
                                    visible: Type == "ComplexType"
                                    x: 20
                                    width: parent.width;
                                    height: 35;
                                    color: "gray"

                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_firstname


                                }
                                Text{
                                    id: text_firstname
                                    height: 10
                                    text:qsTr("first name")
                                    width: parent.width/2.5;
                                    anchors.top: textfield_firstname.bottom
                                    color: "white"
                                }

                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_lastname
                                    anchors.left: textfield_firstname.right

                                }
                                Text{
                                    height: 10
                                    text:qsTr("last name")
                                    anchors.top: textfield_lastname.bottom
                                    anchors.left: text_firstname.right
                                    color: "white"
                                }
                                }

                                Rectangle {
                                    id: itemPhone
                                    visible: Type == "Phone"
                                    x: 20
                                    width: parent.width;
                                    height: 35;
                                    color: "gray"

                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_firstname


                                }
                                Text{
                                    id: text_firstname
                                    height: 10
                                    text:qsTr("first name")
                                    width: parent.width/2.5;
                                    anchors.top: textfield_firstname.bottom
                                    color: "white"
                                }

                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width/2.5;
                                    id: textfield_lastname
                                    anchors.left: textfield_firstname.right

                                }
                                Text{
                                    height: 10
                                    text:qsTr("last name")
                                    anchors.top: textfield_lastname.bottom
                                    anchors.left: text_firstname.right
                                    color: "white"
                                }
                                }

                                Rectangle {
                                    id: itemEmail
                                    visible: Type == "Email"
                                    x: 20
                                    //y: 20
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
                                    id: item1
                                    visible: Type == "TextField"
                                    x: 20
                                    //y: 20
                                    width: parent.width;
                                    height: 20;
                                    color: "gray"
                                TextField {
                                    height: 25
                                    font.pixelSize: 15
                                    width: parent.width;
                                    id: email_item

                                }
                                }

                                Rectangle {
                                    width: parent.width;
                                    color: "gray"
                                    height: 75
                                    id: item2
                                    visible: Type == "TextArea"
                                    x: 20
                                    //y: 10
                                TextArea {
                                    height: 75
                                    font.pixelSize: 15
                                    id: textarea_item
                                  /*  Component.onCompleted: {
                                        item_list.height = 160
                                        }*/
                                }
                                }
                    /*
                        Checkbox nog niet werkend. Een listview nog aan koppelen om meerdere weer te geven.
                        Idem maken voor radiobuttons
                    */

                                Rectangle {
                                    width: parent.width;
                                    color: "gray"
                                    height: 150
                                    id: item4
                                    visible: Type == "CheckBox"
                                    x: 20
                                    //y: 10
                                    Row{
                                        id: rowcheckbox
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
                                    ScrollView {
                                        //contentWidth: columnCheckbox.width; contentHeight: columnCheckbox.height
                                        anchors.top: rowcheckbox.bottom
                                        width: 180; height: 150
                                        /*Component.onCompleted: {
                                            item_list.height = 300
                                            }*/
                                    Column{
                                        id: columnCheckbox
                                        spacing: 20
                                       // height: 20
                                        width: parent.width


                                    Repeater {
                                            id: rep
                                            model: List
                                            Row{
                                                spacing: 20
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

                                }
                                Rectangle {
                                    height: 30
                                    width: parent.width
                                    id: item3
                                    visible: qsTr(Type) === "ComboBox"
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
                                TextField {
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
                                               onClicked: {
                                                   enginioModel.remove(index);
                                                   pop_indexFormArrayRegulator(indexForm);
                                               }
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
                    width: rec_formbuilder.width - grid.width
                    height: parent.height - 100//Screen.height - grid.height

                    // Animations
                    add: Transition { NumberAnimation { properties: "y"; from: root.height; duration: 250 } }
                    removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 150 } }
                    remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 150 } }

                    anchors.top: actionbar.bottom
                }

                Rectangle{
                    id: actionbar
                    color: "gray"
                    width: Screen.width - grid.width
                    height: 50
                    y:0
                    visible: false;
                    Row{
                        id: rowActionbar
                        height :50
                        x:50
                        width: Screen.width - grid.width
                        spacing: 20;
                     Button{
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
                     }
                    }
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
        actionbar.visible = true;
        fullNamebutton.enabled = true;
        adressbutton.enabled = true;
        emailbutton.enabled = true;
        phonebutton.enabled = true;
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
}


