import QtQuick 2.0
import Sailfish.Silica 1.0
import "../persistence"

Dialog {
    id: addBookDialog

    DialogHeader {
        id: header
        title: qsTr("Add a book to read")
    }

    BooksDao { id: booksDao }

    Column {
        width: parent.width
        anchors.top: header.bottom
        spacing: Theme.paddingLarge

        TextField {
            id: authorTextField
            width: parent.width
            labelVisible: true
            label: qsTr("Author:")
            placeholderText: qsTr("Enter an author name of the book")
            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: titleTextField.focus = true
        }

        TextField {
            id: titleTextField
            width: parent.width
            labelVisible: true
            label: qsTr("Book title:")
            placeholderText: qsTr("Enter a book title")
            EnterKey.enabled: text.length > 0
        }
    }

    onAccepted: {
        booksDao.create(authorTextField.text, titleTextField.text, false)
    }
}
