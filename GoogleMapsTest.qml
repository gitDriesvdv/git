import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0
import QtQuick.Controls 1.4
import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    width: 300
    height: 400

    TextField{
        id: textfield
        onTextChanged: {
            model.clear();
            getData();
        }
    }
    Text {
        id: name
        anchors.left: textfield.right
        text: qsTr("text")
    }
    Text {
        id: name2
        anchors.left: name.right
        text: qsTr("text")
    }
    Text{
        id: name3
        anchors.left: name2.right
        text: qsTr("text1")
    }
    Text{
        id: name4
        anchors.left: name3.right
        //anchors.top: name3.botttom
        text: qsTr("text2")
    }
    Text{
        id: name5
        anchors.left: name4.right
        //anchors.top: name4.bottom
        text: qsTr("text3")
    }
///////////////////
    ListModel {
        id: model
    }

    Component {
            id: listDelegate
            Item {
            width: 250; height: 50
            Rectangle{

                anchors.fill: parent
                Text {
                    id: text1
                    text: listdata
                }
                Text {
                    id : text2
                    visible: false
                    anchors.top: text1.bottom
                    text: listdata1
                }
                MouseArea{
                    id: mousearea2
                                    anchors.fill: parent
                                    onClicked: {
                                        var mySplitResult = listdata.split(",");
                                        name.text = mySplitResult[0];
                                        name2.text = mySplitResult[1];
                                        getData_detail(text2.text)
                                    }
                }
            }
            }
        }

    ListView {
        id: listview
        height: 500
        width: 500
        anchors.top: textfield.bottom
        model: model
        delegate: listDelegate
    }

    function getData() {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+ textfield.text +"&types=address&language=nl&components=country:be&key=AIzaSyAlaSiDm2B3v_xwLhfguwONmNzMrj3ffrc"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                myFunction(xmlhttp.responseText);
                console.log(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    function getData_detail(placeid) {
        var xmlhttp = new XMLHttpRequest();
        var url = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+placeid+"&key=AIzaSyAlaSiDm2B3v_xwLhfguwONmNzMrj3ffrc"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                myFunction_detail(xmlhttp.responseText);
                console.log(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    function myFunction_detail(response) {
        var arr = JSON.parse(response);
        var arr1 = arr.result;
        var arr2 = arr1.address_components;
        for(var i = 0; i < arr2.length; i++) {
            if(arr2[i].types == "street_number")
            {
                 name3.text = arr2[i].long_name;
            }
            if(arr2[i].types == "postal_code")
            {
                 name4.text = arr2[i].long_name;
            }
            if(arr2[i].types[0] == "administrative_area_level_2")
            {
                 name5.text = arr2[i].long_name;
            }
        }
    }

    function myFunction(response) {
        var arr = JSON.parse(response);
        var arr1 = arr.predictions;
        for(var i = 0; i < arr1.length; i++) {
            listview.model.append( {listdata: arr1[i].description,
                                      listdata1: arr1[i].place_id})
        }
    }
////////////////////////////////////////
}
