import QtQuick 2.0
import Sailfish.Silica 1.0
import "../persistence"


Page {
    id: mainPage

    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("Add a book")
                onClicked: pageStack.push(Qt.resolvedUrl("EditBookDialog.qml"))
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
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("ToReadPage.qml"))
                }
            }
            Button {
                text: qsTr("Finished")
                onClicked: pageStack.push(Qt.resolvedUrl("FinishedPage.qml"))
            }
            Button {
                text: qsTr("All Books")
                onClicked: pageStack.push(Qt.resolvedUrl("AllBooksPage.qml"))
            }
        }
    }
}
