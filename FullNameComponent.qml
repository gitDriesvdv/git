import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: itemFullName
    x: 20
    width: parent.width;
    height: 35;
    color: "gray"

TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width/2.5;
    id: textfield_firstname


}
Text{
    id: text_firstname
    height: 10
    text:qsTr("first name")
    width: parent.width/2.5;
    anchors.top: textfield_firstname.bottom
    color: "white"
}

TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width/2.5;
    id: textfield_lastname
    anchors.left: textfield_firstname.right

}
Text{
    height: 10
    text:qsTr("last name")
    anchors.top: textfield_lastname.bottom
    anchors.left: text_firstname.right
    color: "white"
}
}

