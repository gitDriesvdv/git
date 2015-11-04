import QtQuick 2.0
import QtQuick 2.1
import Enginio 1.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1

Rectangle{
    height: 800
    width: 1000
    anchors.fill: parent

    EnginioClient {
        id: enginioClient
        backendId: "54be545ae5bde551410243c3"
        onError: {
        console.debug(JSON.stringify(reply.data))
        enginioModelErrors.append({"Error": "Enginio" + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
        }
    }
    /*EnginioModel {
        id: enginioModel
        client: enginioClientLog
        query: {
            "objectType": "objects.resultforms",
            "query" : { "user": "Dries", "formName" : "azerty"},
            "sort" : [ {"sortBy": "indexForm", "direction": "asc"} ]
        }
    }*/
    Rectangle{
        id: loglist
        height: 400
        width: 800

    ColumnLayout {


    anchors.margins: 3
    spacing: 3
    height: 400
    width: 800
    TableView {
        Layout.fillWidth: true
        Layout.fillHeight: true

        TableViewColumn { title: "fieldname"; role: "fieldname" }
        TableViewColumn { title: "input"; role: "input" }
        TableViewColumn { title: "list"; role: "list" }

        model: EnginioModel {
            id: enginioModel
            client: enginioClient
            query: {
                "objectType": "objects.resultforms",
                "query" : { "user": "Dries", "formname" : "azerty"}
            }
        }
        Component.onCompleted: readModels();
    }

    Button {
        text: "Refresh"
        Layout.fillWidth: true

        onClicked: {
            var tmp = enginioModel.query
            enginioModel.query = null
            enginioModel.query = tmp
        }
    }
}
    }

    function readModels()
    {
        var lijst = [];
        lijst = enginioModel;
        console.log(enginioModel);
        for(var a = 0; a < lijst.length;i++)
        {
            console.log(lijst[a].user);
        }
    }
    
    
}


