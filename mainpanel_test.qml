import QtQuick 2.0
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0

        Rectangle {
            id: main
            width: Screen.width
            height: Screen.height
            color: "white"


            //property var imagesUrl: new Object
            Rectangle {

                id: root
                width: Screen.width
                height: Screen.height
                color: "gray"

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
                        "objectType": "objects.OS_components",
                        "include": {"file": {}},
                        "query" : {"active" : true ,"file": { "$ne": null } }
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
                           Rectangle{
                               height: 50
                               width: 200
                               Rectangle {
                                    y: -1 ; height: 1
                                    width: parent.width
                                   color: "#bbb"
                               }
                               Rectangle{
                                   id: colorvalidator
                                   width: 10
                                   height: 50
                                   x: 0
                                   y: 0
                                   color: "white"
                               }
                               Rectangle{
                                   height: 50
                                   width: 200
                                   anchors.left: colorvalidator.right
                                   color: "gray"
                                   Text {
                                       id : naam
                                       height: parent.height
                                       width: parent.width
                                       verticalAlignment: Text.AlignVCenter
                                       horizontalAlignment: Text.AlignHCenter
                                       font.pixelSize: height * 0.2
                                       text: name
                                       elide: Text.ElideRight
                                       color: "#15B7ED"

                                   }
                               }
                               MouseArea {
                                   id: hitbox
                                   anchors.fill: parent
                                   onClicked: {
                                       loaderDialog.fileId = file.id;
                                       loaderDialog.visible = true
                                       //colorvalidator.color = "blue"
                                   }
                               }
                           }
                       }

                Rectangle {
                    id: header
                    anchors.top: parent.top
                    width: 200
                    height: 50
                    color: "gray"

                   Row {
                        id: logo
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: -4
                        spacing: 6

                        Text {
                            text: "BOARD"
                            anchors.verticalCenter: parent.verticalCenter
                            //anchors.verticalCenterOffset: -3
                            font.bold: true
                            font.pixelSize: 26
                            color: "#15B7ED"
                        }
                    }
                    Rectangle {
                        width: parent.width ; height: 1
                        anchors.bottom: parent.bottom
                        color: "#bbb"
                    }
                }

                Row {
                    id: listLayout

                    Behavior on x {NumberAnimation{ duration: 400 ; easing.type: "InOutCubic"}}
                    anchors.top: header.bottom
                    anchors.bottom: footer.top

                    ListView {
                        id: componentListView
                        model: enginioModel
                        delegate: compListDelegate
                        clip: true
                        width: 200
                        height: Screen.height- header.height
                        add: Transition { NumberAnimation { properties: "y"; from: root.height; duration: 250 } }
                        removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 150 } }
                        remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 150 } }
                    }

                    // Dialog for Loader full size
                    Flickable  {
                        id: loaderDialog
                        width: Screen.width - componentListView.width
                        height: Screen.height - 50
                        visible: false

                        contentWidth: mainloader.width;
                        contentHeight: mainloader.height
                        property string fileId

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
                            color: "black"
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
                            width: parent.width
                            height: parent.height
                            asynchronous: true
                            focus: true
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

                BorderImage {
                    id: footer
                    width: 200
                    height: 0
                    anchors.bottom: parent.bottom
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5
                }
            }

            function sizeStringFromFile(fileData) {
                var str = [];
                if (fileData && fileData.fileSize) {
                    str.push("Size: ");
                    str.push(fileData.fileSize);
                    str.push(" bytes");
                }
                return str.join("");
            }

            function doubleDigitNumber(number) {
                if (number < 10)
                    return "0" + number;
                return number;
            }

            function timeStringFromFile(fileData) {
                var str = [];
                if (fileData && fileData.createdAt) {
                    var date = new Date(fileData.createdAt);
                    if (date) {
                        str.push("Uploaded: ");
                        str.push(date.toDateString());
                        str.push(" ");
                        str.push(doubleDigitNumber(date.getHours()));
                        str.push(":");
                        str.push(doubleDigitNumber(date.getMinutes()));
                    }
                }
                return str.join("");
            }

        }



    //}


