import QtQuick 2.0
import Sailfish.Silica 1.0
import org.fruct.yar 1.0
import "../persistence"

Page {

    property int booksState

    BooksDao {id: booksDao}
    BookListModel {id: bookListModel}

    SilicaListView {
        id: listView
        anchors.fill: parent
        header: PageHeader {
            title: {
                if (booksState == BooksStateEnum.ToRead) {
                    qsTr("To Read")
                } else if (booksState == BooksStateEnum.Finished) {
                    qsTr("Finished")
                } else {
                    qsTr("All books")
                }
            }
        }
        model: bookListModel
        delegate: ListItem {
            Column {
                Label {
                    id: titleLabel
                    text: title
                    x: Theme.horizontalPageMargin
                    font.strikeout: finished ? true : false
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
            booksDao.retrieveBooks(booksState, function(books) {
                for (var i = 0; i < books.length; i++) {
                    var book = books.item(i);
                    listView.model.addBook(book.author, book.title, book.finished === 1)
                }
            })
        }
        Component.onCompleted: displayBooks()
    }
}
