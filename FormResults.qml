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
    property variant tableArray: [];
    EnginioClient {
        id: enginioClient
        backendId: "54be545ae5bde551410243c3"
        onError: {
        console.debug(JSON.stringify(reply.data))
        enginioModelErrors.append({"Error": "Enginio" + reply.errorCode + ": " + reply.errorString + "\n\n", "User": "Admin"})
        }
    }

    EnginioModel {
                id: enginioModel
                client: enginioClient
                query: {
                    "objectType": "objects.resultforms",
                    "query" : { "user": "Dries", "formname" : "azerty"}
                }
            }
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
        id: table
        Layout.fillWidth: true
        Layout.fillHeight: true

       // TableViewColumn { title: "fieldname"; role: "fieldname" }
       // TableViewColumn { title: "input"; role: "input" }
       // TableViewColumn { title: "list"; role: "list" }

        model: listmodel
        Component.onCompleted: {


        }
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
    ListModel{
        id: listmodel
    }

    Component{
        id: listDelegate
        Item{
            Component.onCompleted: {
                //table.addColumn()
                listmodel.append({fieldname: input});
                //table.insertColumn( TableViewColumn { role: "title"; title: "Title"; width: 100 });
                //readModels(fieldname,fieldname);
                table.addColumn(1, { title: fieldname, role: "fieldname" });

            }
        }
    }

    ListView {
        id: formListView
        model: enginioModel
        delegate: listDelegate
        visible: false
    }

    function readModels(role,title)
    {

        for(var i = 0; i < tableArray.length;i++)
        {
            if(tableArray[i].role === role)
            {
                return false;
            }
        }
        //var a = { "role": role ,"title":title };
        //tableArray.push(a);
        table.addColumn( { title: tableArray[i].title, role: tableArray[i].role });
        return true;
    }
    
    
}


