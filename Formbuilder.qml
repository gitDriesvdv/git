import QtQuick 2.0
import QtQuick.Layouts 1.1
import Enginio 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0

Rectangle {
    width: Screen.width
    height: Screen.height

     property string aFormname: ""

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
            "objectType": "objects.Form",
            "query" : { "User": "Dries", "FormName" : aFormname}
        }
    }

    //FormName

    GridLayout {
        id: grid
        columns: 2
        columnSpacing: 40

        Button{
            id: firstbutton
            text: "Textfield"
            enabled: false
            onClicked: {
                enginioModel.append({"FormName":aFormname,"User": "Dries", "Name": "Blanck", "Type" : "TextEdit"})
            }
        }
    }
    Rectangle{
        //anchors.fill: parent
        width: Screen.width - grid.width
        height: Screen.height - grid.height
        anchors.left: grid.right
        color: "gray"

        Rectangle {
            id: newform
            anchors.centerIn: parent
            TextField {
                id: nameForm
                Layout.fillWidth: true
                placeholderText: "Username"
            }
            Button{
                id: startbutton
                text: "Start"
                onClicked: {
                    enableButtons()
                }
                anchors.top: nameForm.bottom
            }
        }

            Component {
                id: listDelegate
                Item {
                width: 460; height: 60

                    Row {
                     Column {
                         id: col
                         width: 200
                        TextField {
                            id: naam
                            x: 20
                            text: Name
                        }
                         Rectangle{
                             anchors.top: naam.bottom
                             height: 25
                             id: firstname
                             visible: Type == "TextEdit"
                             x: 20
                         TextField {
                             height: 25
                             font.pixelSize: 15
                             id: labelfirstname
                             placeholderText: color
                         }
                         }

                        }
                     Button {
                                id: removeIcon
                                text: "remove"
                                anchors.margins: 20
                                anchors.verticalCenter: col.verticalCenter
                                anchors.left: col.right
                                opacity: enabled ? 1 : 0.5
                                Behavior on opacity {NumberAnimation{duration: 100}}
                                onClicked: enginioModel.remove(index)
                             }
                    }
                }
            }

            Rectangle{
                id: form
                visible: false
                width: Screen.width - grid.width
                height: Screen.height - grid.height
                anchors.left: grid.right
                color: "gray"
                y: 50
            Row {
                id: listLayout
                Behavior on x {NumberAnimation{ duration: 400 ; easing.type: "InOutCubic"}}
                //anchors.top: knoppen.bottom
                //anchors.bottom: footer.top
                anchors.fill: parent

                ListView {
                    id: formListView
                    interactive: false
                    model: enginioModel
                    delegate: listDelegate
                    clip: true
                    //width: parent.width
                    //height: parent.height
                    width: Screen.width - grid.width
                    height: Screen.height - grid.height

                    // Animations
                    add: Transition { NumberAnimation { properties: "y"; from: root.height; duration: 250 } }
                    removeDisplaced: Transition { NumberAnimation { properties: "y"; duration: 150 } }
                    remove: Transition { NumberAnimation { property: "opacity"; to: 0; duration: 150 } }
                }
            }
            }
    }
    function enableButtons()
    {
        aFormname = nameForm.text;
        firstbutton.enabled = true;
        form.visible = true;
        newform.visible = false;
    }
}

