import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Rectangle {
    id :rect
    width: parent.width
   height: parent.height - 200
    color: "gray"
    GridLayout{
        id: grid
        columns: 2
        Rectangle{
            id: rec1
            width: rect.width/2
            height: rect.height/2
            color: "red"
            // all gebruikers

        }
        Rectangle{
            id: rec2
            width: rect.width/2
            height: rect.height/2
            color: "blue"
            //gebruikers toevoegen

        }
        Rectangle{
            id: rec3
            width: rect.width/2
            height: rect.height/2
            color: "blue"
            //bedrijfsinformatie

        }
        Rectangle{
            id: rec4
            width: rect.width/2
            height: rect.height/2
            color: "red"

        }
    }
}

