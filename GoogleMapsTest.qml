import QtQuick 2.0
import QtQuick.Controls 1.2

import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0
import QtWebKit 3.0

Item {
    property var arr: [];
    anchors.fill: parent

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: spacing

        RowLayout {
            TextField {
                id: hostTextField
                Layout.fillWidth: true
                Layout.minimumHeight: 80
                text: "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=Vict&types=geocode&language=fr&key=AIzaSyAlaSiDm2B3v_xwLhfguwONmNzMrj3ffrc"
            }

            Item {
                Layout.fillWidth: true
            }

            Button {
                Layout.minimumHeight: 80
                text: "Send request"

                onClicked: {
                    var request = new XMLHttpRequest()
                    request.open("GET", hostTextField.text)
                    request.onreadystatechange = function () {
                        if (request.readyState === XMLHttpRequest.DONE) {
                            if (request.status === 200) {
                                listview.model = JSON.parse(request.responseText)
                                responseTextArea.text = request.responseText
                                arr = JSON.parse(request.responseText);
                                console.log("ok" + arr.length);
                                        for(var i = 0; i < arr.length; i++) {
                                            model.append( {"listdata": arr.predictions[i].description })
                                            console.log("ok");
                                        }
                            } else {
                                responseTextArea.text = "HTTP request failed " + request.status
                            }
                        }
                    }
                    request.send()
                }
            }
        }

        TextArea {
            id: responseTextArea
           // Layout.fillWidth: true
           // Layout.fillHeight: true
        }
        ListModel {
               id: model
           }

        Rectangle{
            id: rec
            width: 400
            height: 400
            color: "blue"
            anchors.top: responseTextArea.bottom
           ListView {
               id: listview
               width: 300
               height: 300
               //anchors.fill: parent
               model: arr
               delegate: Text {
                   text: listdata
               }
           }
        }
    }

}
