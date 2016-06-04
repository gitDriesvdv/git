import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: itemEmail
    x: 20
    width: parent.width - 50;
    height: 20;
    color: "white"
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width;
    id: textfield_item
}
}

