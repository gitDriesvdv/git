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
                color: "white"

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
                        "objectType": "objects.OS_components",
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
                                   Text {
                                       id : naam
                                       height: parent.height
                                       width: parent.width
                                       verticalAlignment: Text.AlignVCenter
                                       horizontalAlignment: Text.AlignHCenter
                                       font.pixelSize: height * 0.2
                                       text: name
                                       elide: Text.ElideRight

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
                    width: 500
                    height: 0
                    color: "white"

                   /* Row {
                        id: logo
                        anchors.centerIn: parent
                        anchors.horizontalCenterOffset: -4
                        spacing: 6

                        Text {
                            text: "Components"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -3
                            font.bold: true
                            font.pixelSize: 46
                            color: "#555"
                        }
                    }*/
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
                        model: enginioModel // get the data from EnginioModel
                        delegate: compListDelegate
                        clip: true
                        width: 200
                        height: Screen.height-400
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

                        contentWidth: mainloader.width; contentHeight: mainloader.height
                        property string fileId
                        //color: "#333"

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
                        MouseArea {
                            anchors.fill: parent
                            onClicked: root.state = ""
                        }
                    }

                }

                BorderImage {
                    id: footer
                    width: 500
                    height: 0
                    anchors.bottom: parent.bottom
                    border.left: 5; border.top: 5
                    border.right: 5; border.bottom: 5

                   /* Rectangle {
                        y: -1 ; height: 1
                        width: parent.width
                        color: "#bbb"
                    }*/

                    /*ComboBox {
                        id: os
                        width: 200
                        model: [
                            "android",
                            "blackberry",
                            "ios",
                            "linux",
                            "osx",
                            "unix",
                            "windows",
                            "wince",
                            "winrt",
                            "winphone"
                        ]
                    }

                    TextField{
                        id: name
                        anchors.top: os.bottom
                        height: 40
                        width: 400
                        placeholderText: "Name"
                    }

                    Rectangle{
                    id : upload
                    anchors.top: name.bottom

                    Button {
                        text: "Click to upload..."
                        onClicked: fileDialog.visible = true;
                    }

                    }
                    Rectangle {
                        id: progressBar
                        property real value:0
                        anchors.bottom: parent.bottom
                        width: parent.width * value
                        height: 4
                        color: "#49f"
                        Behavior on opacity {NumberAnimation {duration: 100}}
                    }*/
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


