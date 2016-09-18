import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: mainPage
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Add a book")
                onClicked: pageStack.push(Qt.resolvedUrl("AddBookDialog.qml"))
            }
        }
        PageHeader {
            id: header
            width: parent.width
            title: qsTr("Books to read")
        }
        Column {
            anchors.centerIn: parent
            spacing: Theme.paddingLarge

            Button {
                text: qsTr("To Read")
            }
            Button {
                text: qsTr("Finished")
            }
            Button {
                text: qsTr("All Books")
            }
        }
    }
}


