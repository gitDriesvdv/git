import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.4
Item {
    id: tabViewTest
    width: Screen.width
    height: Screen.height

    TabView {
        id: tabView
        width: Screen.width
        height: Screen.height
        tabPosition: Qt.BottomEdge

        Tab {
            title: "Welcome"
            id: dynamicTab
            anchors.top: parent.top
            width: Screen.width
            height: Screen.height

            // [1] Specify the source URL to load the content.
            source: "FormView_mobile.qml"

            // [2] Define a signal within the Tab that will
            // be connected to the 'contentsClicked' signal
            // in each tab QML file.
            signal tabContentsClicked( string rectColor )

            // [3] Implement the signal handler.
            onTabContentsClicked: {
                console.log( "Clicked on a", rectColor, "rectangle." )

                // [4] Now that the user has clicked somewhere within the tab
                // you could optionally the source or sourceComponent here like
                // the comment below.
                //
                // Just make sure it also has a signal called 'contentsClicked'
                //
                // dynamicTab.source = "someOtherTab.qml"
            }

            onLoaded: {
                console.debug( "Loaded", source );

                // [4] Here's the key action, connect the signal
                // 'contentsClicked' to our signal
                // 'tabContentsClicked' from the loaded item
                // i.e. RectanglesTab.qml
                dynamicTab.item.contentsClicked.connect(tabContentsClicked)
            }
        }

        Tab {
            id: statusTab
            title: "Status"
        }
        style: TabViewStyle {
                frameOverlap: 1
                tab: Rectangle {
                    color: styleData.selected ? "steelblue" :"lightsteelblue"
                    border.color:  "steelblue"
                    implicitWidth: Screen.width/2
                    implicitHeight: Screen.height/13
                    radius: 2
                    Text {
                        id: text
                        anchors.centerIn: parent
                        text: styleData.title
                        color: styleData.selected ? "white" : "black"
                    }
                }
                frame: Rectangle { color: "steelblue" }
            }
    }
}


