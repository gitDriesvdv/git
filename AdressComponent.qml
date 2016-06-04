import QtQuick 2.0
import QtQuick.Controls 1.4
Rectangle {
    id: itemAdress
    x: 20
    width: parent.width - 50;
    height: 150;
    color: "white"

    //straat + nummer
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width;
    id: textfield_street

}
Text{
    id: text_streetname
    height: 20
    text:qsTr("streetname + number")
    width: parent.width/2.5;
    anchors.top: textfield_street.bottom
    color: "black"
}

//plaats
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width/2.5;
    id: textfield_place
    anchors.top: text_streetname.bottom
}
Text{
    id: text_place
    height: 20
    text:qsTr("place")
    width: parent.width/2.5;
    anchors.top: textfield_place.bottom
    color: "black"
}

//staat
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width/2.5;
    id: textfield_state
    anchors.top: text_streetname.bottom
    anchors.left: textfield_place.right

}
Text{
    id: text_state
    height: 20
    text:qsTr("State")
    anchors.top: textfield_state.bottom
    anchors.left: text_place.right
    color: "black"
}

//postcode
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width/2.5;
    id: textfield_postcode
    anchors.top: text_state.bottom

}
Text{
    id: text_postcode
    height: 20
    width: parent.width/2.5;
    text:qsTr("zip code")
    anchors.top: textfield_postcode.bottom
    color: "black"
}

//land
TextField {
    height: 25
    font.pixelSize: 15
    width: parent.width/2.5;
    id: textfield_country
    anchors.top: text_state.bottom
    anchors.left: textfield_postcode.right

}
Text{
    id: text_country
    height: 20
    text:qsTr("country")
    anchors.top: textfield_country.bottom
    anchors.left: text_postcode.right
    color: "black"
}
}

