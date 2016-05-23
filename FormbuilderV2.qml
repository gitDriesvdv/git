import QtQuick 2.0
import QtQuick.Layouts 1.1
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
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
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 70 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "TextField","req":"false"})
            }
        }
        Button{
            id: textAreabutton
            text: "Textarea"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":4,"heightItem": 170 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "TextArea","req":"false"})
            }
        }
        Button{
            id: comboboxbutton
            text: "Combobox"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 100 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "ComboBox","List":[],"req":"false"})
            }
        }
        Button{
            id: checkboxbutton
            text: "Checkbox"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":4,"heightItem": 200 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "CheckBox","List":[],"req":"false"})
            }
        }
        Button{
            id: fullNamebutton
            text: "Full Name"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Full Name", "Type" : "ComplexType","req":"false"})
            }
        }
        Button{
            id: emailbutton
            text: "Email"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Email", "Type" : "Email","req":"false"})
            }
        }
        Button{
            id: adressbutton
            text: "Adress"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":4,"heightItem": 250 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Adress", "Type" : "Adress","req":"false"})
            }
        }
        Button{
            id: numberbutton
            text: "Number"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": aFieldname, "Type" : "Number","req":"false"})
            }
        }
        Button{
            id: phonenumberbutton
            text: "Phone"
            enabled: false
            onClicked: {
                indexRegulator();
                enginioModel.append({"heightItem_mobile":8,"heightItem": 90 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Phone", "Type" : "phone","req":"false"})
            }
        }
        Button{
            id: personebutton
            text: "Persone"
            enabled: false
            onClicked: {
                indexRegulator();
                    enginioModel.append({"heightItem_mobile":4,"heightItem": 500 ,"indexForm": aIndexForm,"FormName":aFormname,"User": settings.username, "Name": "Persone", "Type" : "Persone","req":"false"})
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
                placeholderText: "New Form"
            }
            Component.onCompleted: getDataUserForms(settings.username)
            ComboBox{
                id: comboboxForms
                anchors.top: nameForm.bottom
                model: ListModel{
                    id: lijstmodel
                }
            }

            Button {
                id: startbutton
                anchors.top: comboboxForms.bottom
                text: "Start"
                onClicked: {
                    enableButtons()
                }
                //anchors.top: nameForm.bottom
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
                                                           xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
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
                                                      xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
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
                                                      xhr.setRequestHeader("Enginio-Backend-Id", settings.myBackendId)
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

