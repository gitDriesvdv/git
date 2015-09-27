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


    //property var imagesUrl: new Object
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
                       Image {
                           id: image
                           x: 10
                           width: 0
                           height: 100
                           anchors.verticalCenter: parent.verticalCenter
                           Behavior on opacity { NumberAnimation { duration: 100 } }
                       }

                       Column {
                           anchors.left: image.right
                           anchors.right: deleteIcon.left
                           anchors.margins: 12
                           y: 10
                           x: 10
                           Text {
                               id : naam
                               height: 20
                               width: parent.width
                               verticalAlignment: Text.AlignVCenter
                               font.pixelSize: height * 0.5
                               text: name
                               elide: Text.ElideRight
                           }
                           Text {
                               height: 20
                               width: parent.width
                               verticalAlignment: Text.AlignVCenter
                               font.pixelSize: height * 0.5
                               text: type
                               elide: Text.ElideRight
                           }
                           Text {
                               height: 20
                               width: parent.width
                               verticalAlignment: Text.AlignVCenter
                               font.pixelSize: height * 0.5
                               text: sizeStringFromFile(file)
                               elide:Text.ElideRight
                               color: "#555"
                           }
                           Text {
                               height: 20
                               width: parent.width
                               verticalAlignment: Text.AlignVCenter
                               font.pixelSize: height * 0.5
                               text: timeStringFromFile(file)
                               elide:Text.ElideRight
                               color: "#555"
                           }
                       }

                       MouseArea {
                           id: hitbox
                           anchors.fill: parent
                           onClicked: {
                               loaderDialog.fileId = file.id;
                               loaderDialog.visible = true
                           }
                       }

                       // Delete button
                       Button {
                           id: deleteIcon
                           text: "Delete"
                           anchors.right: parent.right
                           anchors.verticalCenter: parent.verticalCenter
                           anchors.rightMargin: 18
                           onClicked: {
                               enginioModel.remove(index)
                               enginioModelLogs.append({"Log": name + " File Removed", "User": "Admin"})
                           }
                       }
                   }
               }

        Rectangle {
            id: header
            anchors.top: parent.top
            width: 500
            height: 70
            color: "white"

            Row {
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
            Flickable  {
                id: loaderDialog
                width: 500
                height: 600
                contentWidth: mainloader.width; contentHeight: mainloader.height
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
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.state = ""
                }
            }

        }

        BorderImage {
            id: footer
            width: 500
            height: 110
            anchors.bottom: parent.bottom
            border.left: 5; border.top: 5
            border.right: 5; border.bottom: 5

            Rectangle {
                y: -1 ; height: 1
                width: parent.width
                color: "#bbb"
            }

            ComboBox {
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
            }
        }

        // File dialog for selecting file from local file system
        FileDialog {
            id: fileDialog
            title: "Select QML file to upload"

            onSelectionAccepted: {
                var pathParts = fileUrl.toString().split("/");
                var fileName = pathParts[pathParts.length - 1];
                var fileObject = {
                    objectType: "objects.OS_components",
                    name: name.text,
                    type: os.currentText,
                    localPath: fileUrl.toString()
                }
                var reply = client.create(fileObject);
                reply.finished.connect(function() {
                    var uploadData = {
                        file: { fileName: fileName },
                        targetFileProperty: {
                            objectType: "objects.OS_components",
                            id: reply.data.id,
                            propertyName: "file"
                        },
                    };

                    var uploadReply = client.uploadFile(uploadData, fileUrl)
                    progressBar.opacity = 1
                    uploadReply.progress.connect(function(progress, total) {
                        progressBar.value = progress/total
                    })
                    uploadReply.finished.connect(function() {
                        var tmp = enginioModel.query; enginioModel.query = null; enginioModel.query = tmp;
                        progressBar.opacity = 0
                        if (uploadReply.errorType !== EnginioReply.NoError) {
                            messageDialog.text = "Failed to create an account:\n" + JSON.stringify(uploadReply.data, undefined, 2) + "\n\n"
                            enginioModelErrors.append({"Error": name.text + " Failed to add file :\n" + JSON.stringify(uploadReply.data, undefined, 2) + "\n\n", "User": "Admin"})
                        } else {
                            messageDialog.text = "File added.\n"
                            enginioModelLogs.append({"Log": name.text + " File Added", "User": "Admin"})
                            name.text = "";
                        }
                        messageDialog.visible = true;
                    })
                })

            }
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


