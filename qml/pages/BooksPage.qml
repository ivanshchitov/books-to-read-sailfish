import QtQuick 2.0
import Sailfish.Silica 1.0
import org.fruct.yar 1.0
import "../persistence"
import "../menu"

Page {

    property int booksState

    BooksDao {id: booksDao}
    BookListModel {id: bookListModel}

    SilicaListView {

        AddBookPullDownMenu {}

        id: listView
        anchors.fill: parent
        currentIndex: 0
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
                    font.strikeout: finished
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
                    text: finished ? qsTr("Mark as To Read") : qsTr("Mark as Finished")
                    onClicked:{
                        booksDao.update(id, author, title, finished ? 0 : 1);
                        if (booksState == BooksStateEnum.All) {
                            listView.model.updateBook(model.index, author, title, !finished);
                        } else {
                            listView.model.remove(model.index)
                        }
                    }
                }
                MenuItem {
                    text: qsTr("Edit")
                    onClicked: {
                        var dialog = pageStack.push(Qt.resolvedUrl("EditBookDialog.qml"),
                                              {author: author, title: title})
                        dialog.accepted.connect(function() {
                            booksDao.update(id, dialog.author, dialog.title, finished ? 1 : 0);
                            listView.model.updateBook(model.index, dialog.author, dialog.title, finished);
                        });
                    }
                }
                MenuItem {
                    text: qsTr("Delete")
                    onClicked: {
                        booksDao.deleteBook(id);
                        listView.model.remove(model.index)
                    }
                }
            }
        }
        function displayBooks() {
            listView.model.clear();
            booksDao.retrieveBooks(booksState, function(books) {
                for (var i = 0; i < books.length; i++) {
                    var book = books.item(i);
                    listView.model.addBook(book.id, book.author, book.title,
                                           book.finished === 1)
                }
            })
        }
        Component.onCompleted: displayBooks()
    }
}
