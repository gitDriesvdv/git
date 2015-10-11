import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

Rectangle {
    id :rec
    width: Screen.width
   height: Screen.height - 200
    color: "gray"
    GridLayout{
        id: grid
        columns: 2
        Rectangle{
            id: rec1
            width: rec.width/2
            height: rec.height/2
            color: "red"
            // all gebruikers

        }
        Rectangle{
            id: rec2
            width: rec.width/2
            height: rec.height/2
            color: "blue"
            //gebruikers toevoegen

        }
        Rectangle{
            id: rec3
            width: rec.width/2
            height: rec.height/2
            color: "blue"
            //bedrijfsinformatie

        }
        Rectangle{
            id: rec4
            width: rec.width/2
            height: rec.height/2
            color: "red"

        }
    }
}

