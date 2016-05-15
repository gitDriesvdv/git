import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {
    id: itemPhone
    x: 20
    width: parent.width;
    height: 20;
    color: "gray"
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width;
    inputMethodHints : Qt.ImhDigitsOnly
    id: textfield_itemPhone
}
}

