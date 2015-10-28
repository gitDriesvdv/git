import QtQuick 2.0
import Enginio 1.0
import QtQml 2.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.2
import QtMultimedia 5.4
import Qt.labs.settings 1.0
import QtQuick.Dialogs 1.1

Item {
    id: main
    property var imagesUrl: new Object
    Rectangle {
        id: root
        anchors.fill: parent
        opacity: 1
        color: "#f4f4f4"

        EnginioClient {
            id: client
            backendId: "54be545ae5bde551410243c3"
            onError: console.log("Enginio error: " + reply.errorCode + ": " + reply.errorString)
        }
        EnginioModel {
            id: enginioModel
            client: client
            query: {"objectType": "objects.OS_components",
                    "include": {"file": {}},
                    "query" : { "type": Qt.platform.os, "name" : "FormBuilder_desktop" } }
        }
        EnginioModel {
                id: enginioModelErrors
                client: client
                query: {
                    "objectType": "objects.Errors"
                }
            }
        Label {
                            id: label
                            text: "loading all components ..."
                            font.pixelSize: 28
                            color: "black"
                            anchors.centerIn: parent
                            visible: mainloader.status != Loader.Ready
                        }
        MessageDialog {
            id: messageDialog
            title: "Message"
        }
        Component {
            id: gridDelegate
            Rectangle {
                height: main.height
                width: main.width
                //border.top: 4
                //border.bottom: 4
                //source: "qrc:/new/prefix1/delegate kopie.png"

                Loader {
                    id: mainloader
                    width: main.width
                    height: main.height
                    anchors.verticalCenter: parent.verticalCenter
                    Behavior on opacity { NumberAnimation { duration: 100 } }

                   //Dit is voor QML uit database
                   /* Component.onCompleted: {
                        mainloader.source = ""
                            var data = { "id": file.id }
                            var reply = client.downloadUrl(data)
                            reply.finished.connect(function() {
                                mainloader.source = reply.data.expiringUrl
                            })
                    }*/

                    //Dit gebruiken voor de testen
                    source : "qrc:/Formbuilder.qml"

                    onStatusChanged:{
                        if (mainloader.status === Loader.Error)
                        {
                            reload();
                            if(mainloader.status === Loader.Error)
                            {
                                messageDialog.visible = true;
                                messageDialog.text = "Trying to reload not worked";
                            }
                        }
                    }

                }

                Rectangle {
                    color: "transparent"
                    anchors.fill: mainloader
                    border.color: "#aaa"
                    Rectangle {
                        id: progressBar
                        property real value:  mainloader.progress
                        anchors.bottom: parent.bottom
                        width: mainloader.width * value
                        height: 40
                        color: "#49f"
                        opacity: mainloader.status != Loader.Ready ? 1 : 0
                        Behavior on opacity {NumberAnimation {duration: 100}}
                    }
                }
            }
        }
        GridView{
            id: gridview
            model: enginioModel
            delegate: gridDelegate
            width: root.width
            height: parent.height
        }
    }
    function reload()
    {
            var tmp = enginioModel.query
            enginioModel.query = null
            enginioModel.query = tmp
    }

    function reloadLoader()
    {
        messageDialog.text = "Trying to reload";
        messageDialog.visible = true;
        for(var i = 0; i < 3; i++)
        {
            var tmp = enginioModel.query
            enginioModel.query = null
            enginioModel.query = tmp
            if(mainloader.status === Loader.Ready)
            {
                messageDialog.visible = false;
                return true;
            }
        }
        messageDialog.visible = false;
        return false;
    }
}
