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

    ListModel {
        id: model
    }

    Component {
            id: listDelegate
            Item {
            width: 250; height: 50
            Rectangle{

                anchors.fill: parent
                Text { text: listdata }
                MouseArea{
                    id: mousearea2
                                    anchors.fill: parent
                                    onClicked: {
                                        var mySplitResult = listdata.split(",");

                                        name.text = mySplitResult[0];
                                        name2.text = mySplitResult[1];
                                        console.debug("list click")
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
        var url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+ textfield.text +"&types=(cities)&language=nl&components=country:be&key=AIzaSyAlaSiDm2B3v_xwLhfguwONmNzMrj3ffrc"

        xmlhttp.onreadystatechange=function() {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                myFunction(xmlhttp.responseText);
                console.log(xmlhttp.responseText);
            }
        }
        xmlhttp.open("GET", url, true);
        xmlhttp.send();
    }

    function myFunction(response) {
        var arr = JSON.parse(response);
        //console.log(listdata);
        var arr1 = arr.predictions;
        for(var i = 0; i < arr1.length; i++) {
            listview.model.append( {listdata: arr1[i].description})
        }
    }

    Button {
        anchors.bottom: parent.bottom
        width: parent.width
        text: "Get Data"
        onClicked: getData()
    }
}
