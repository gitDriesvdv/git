import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick 2.5
Rectangle {
    id: itemAPersoon
    x: 20
    width: parent.width;
    height: 500;
    color: "gray"
FullNameComponent{
    id: fullname
}

AdressComponent{
    id: adress
    anchors.top: fullname.bottom
}
Column {
    id: gender
    x: 20
    anchors.top: adress.bottom
    CheckBox {
        text: qsTr("Male")
        checked: true
    }
    CheckBox {
        text: qsTr("Female")
    }
}
Calendar {
    x:20
    weekNumbersVisible: true
     anchors.top: gender.bottom
}
}


