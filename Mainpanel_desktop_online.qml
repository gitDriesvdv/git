import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0
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
            backendId: settings.myBackendId
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
                "query" : {"active":true}
                //}
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

                   Rectangle {
                       id: borderImage
                       height: 90
                       width: 500
                           Text {
                               id : naam
                               x: 30
                               y: 30
                               height: 20
                               width: parent.width
                               verticalAlignment: Text.AlignVCenter
                               font.pixelSize: height * 0.5
                               text: tab
                           }

                       MouseArea {
                           id: hitbox
                           anchors.fill: parent
                           onClicked: {
                               console.log("klik")
                               //loaderDialog.fileId = file.id;
                               loaderDialog.visible = true
                               mainloader.visible =  true
                           }
                       }
                       /*Rectangle {
                           anchors.top: borderImage.bottom
                           height: 3
                           width: parent.width
                           color: "#bbb"
                       }*/
                   }

               }

        Row {
            id: listLayout
            Behavior on x {NumberAnimation{ duration: 400 ; easing.type: "InOutCubic"}}

            ListView {
                id: imageListView
                model: enginioModel
                delegate: compListDelegate
                //clip: true
                width: Screen.width/5
                height: Screen.height
            }

            // Dialog for Loader full size
            Rectangle  {
                id: loaderDialog
                width: Screen.width - imageListView.width
                height: Screen.height
                property string fileId
                color: "#333"
                //visible: false

                onFileIdChanged: {
                    mainloader.source = ""
                    var data = { "id": fileId }
                    var reply = client.downloadUrl(data)
                    reply.finished.connect(function() {
                        mainloader.source = reply.data.expiringUrl
                    })
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
                    anchors.fill: parent
                    // visible: false
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
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


