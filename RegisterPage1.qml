import QtQuick 2.0
import QtQml 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1
import QtQml.Models 2.2

NavigationPane {
    id: nav
    Page {
        Container {
            TextField {
                id: field1
                text: ""
            }
            Button {
                text: "Send text to Page 2"
                onClicked: {
                }
            }
            Button {
                text: "Send text to Page 3"
                onClicked: {
                }
            }
            Button {
                text: "Go to Page 2"
                onClicked: {
                    nav.push(pushed)
                }
            }
            Label {
                id: label1
                text: "Main Page Label: "
            }
        }
    }
    attachedObjects: [
        Pagetwo {
            id: pushed
        },
        Pagethree {
            id: pushed2
        }
    ]
}

