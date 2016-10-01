import QtQuick 2.0
import Sailfish.Silica 1.0
import org.fruct.yar 1.0
import "../persistence"
import "../menu"


Page {
    id: mainPage

    property var coverPage: appWindow.cover

    BooksDao {id: booksDao}

    SilicaFlickable {
        anchors.fill: parent

        AddBookPullDownMenu {}

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
                onClicked: pageStack.push(Qt.resolvedUrl("BooksPage.qml"), {booksState: BooksStateEnum.ToRead, coverPage: coverPage})
            }
            Button {
                text: qsTr("Finished")
                onClicked: pageStack.push(Qt.resolvedUrl("BooksPage.qml"), {booksState: BooksStateEnum.Finished, coverPage: coverPage})
            }
            Button {
                text: qsTr("All Books")
                onClicked: pageStack.push(Qt.resolvedUrl("BooksPage.qml"), {booksState: BooksStateEnum.All, coverPage: coverPage})
            }
        }
    }
}
