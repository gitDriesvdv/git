import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
Item {
    id: main
    width: 500
    height: 640

    Rectangle {

        id: root
        color: "#f4f4f4"
        width: 500
        height: 540

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
                "objectType": "objects.Tabs",
                "include": {"file": {}},
                "query" : { "file": { "$ne": null } }
            }
        }
        EnginioModel {
            id: enginioModelLogs
            client: client
            query: {
                "objectType": "objects.Logs"
            }
        }

        EnginioModel {
            id: enginioModelErrors
            client: client
            query: {
                "objectType": "objects.Errors"
            }
        }

        MessageDialog {
            id: messageDialog
            title: "Message"
        }
        Component {
                   id: compListDelegate

                   BorderImage {
                       height: 90
                       width: 500
                       border.top: 4
                       border.bottom: 4
                       Rectangle {
                           y: -1 ; height: 1
                           width: parent.width
                           color: "#bbb"
                       }
                           Text {
                               id : naam
                               x: 30
                               y: 30
                               height: 20
                               width: parent.width
                               verticalAlignment: Text.AlignVCenter
                               font.pixelSize: height * 0.5
                               text: tab
                               elide: Text.ElideRight
                           }

                       MouseArea {
                           id: hitbox
                           anchors.fill: parent
                           onClicked: {
                               loaderDialog.fileId = file.id;
                               loaderDialog.visible = true
                           }
                       }
                   }
               }

        Row {
            id: listLayout
            Behavior on x {NumberAnimation{ duration: 400 ; easing.type: "InOutCubic"}}

            ListView {
                id: imageListView
                model: enginioModel // get the data from EnginioModel
                delegate: compListDelegate
                clip: true
                width: 500
                height: 400
                add: Transition { NumberAnimation { properties: "y"; from: root.height; duration: 250 } }
                removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 150 } }
                remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 150 } }
            }

            // Dialog for Loader full size
            Rectangle  {
                id: loaderDialog
                width: 500
                height: 600
                //contentWidth: mainloader.width; contentHeight: mainloader.height
                property string fileId
                //color: "#333"
                visible: false

                onFileIdChanged: {
                    mainloader.source = ""
                    var data = { "id": fileId }
                    var reply = client.downloadUrl(data)
                    reply.finished.connect(function() {
                        mainloader.source = reply.data.expiringUrl
                    })
                }
                Label {
                    id: label
                    text: "Loading ..."
                    font.pixelSize: 28
                    color: "white"
                    anchors.centerIn: parent
                    visible: mainloader.status != Loader.Ready
                }
                Rectangle {
                    property real value: mainloader.progress
                    anchors.bottom: parent.bottom
                    width: parent.width * value
                    height: 4
                    color: "#49f"
                    Behavior on opacity {NumberAnimation {duration: 200}}
                    opacity: mainloader.status !== Loader.Ready ? 1 : 0
                }
                Loader {
                    id: mainloader
                    width: 400
                    height: 400
                    asynchronous: true
                    //anchors.fill: parent
                    //anchors.verticalCenter: parent.verticalCenter
                    //anchors.horizontalCenter: parent.horizontalCenter
                    Behavior on opacity { NumberAnimation { duration: 100 } }
                    Component.onCompleted: {
                        mainloader.source = ""
                            var data = { "id": file.id }
                            var reply = client.downloadUrl(data)
                            reply.finished.connect(function() {
                                mainloader.source = reply.data.expiringUrl
                            })
                    }
                }
            }
        }
    }
}


