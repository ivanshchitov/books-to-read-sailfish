import QtQuick 2.0
import Sailfish.Silica 1.0
import "../persistence"

Page {
    id: toReadPage
    BooksDao {id: booksDao}
    BookListModel {id: bookListModel}
    SilicaListView {
        id: listView
        anchors.fill: parent
        header: PageHeader { title: qsTr("To Read") }
        model: bookListModel
        delegate: ListItem {
            Column {
                Label {
                    id: titleLabel
                    text: title
                    x: Theme.horizontalPageMargin
                }
                Label {
                    id: authorLabel
                    text: author
                    x: Theme.horizontalPageMargin
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Mark as Finished")
                }
                MenuItem {
                    text: qsTr("Edit")
                    onClicked: pageStack.push(Qt.resolvedUrl("EditBookDialog.qml"))
                }
                MenuItem {
                    text: qsTr("Delete")
                }
            }
        }
        function displayBooks() {
            booksDao.retrieveAllBooks(function(books) {
                for (var i = 0; i < books.length; i++) {
                    var book = books.item(i);
                    listView.model.addBook(book.author, book.title, book.finished === 1)
                }
            })
        }

        Component.onCompleted: displayBooks()
    }
}
