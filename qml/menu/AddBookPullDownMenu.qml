import QtQuick 2.0
import Sailfish.Silica 1.0
import org.fruct.yar 1.0

PullDownMenu {

    MenuItem {

        text: qsTr("Add a book")
        onClicked: {
            var dialog = pageStack.push(Qt.resolvedUrl("../pages/EditBookDialog.qml"))
            dialog.accepted.connect(function() {
                var insertId = booksDao.create(
                           dialog.author, dialog.title, false,
                           function(insertId) {
                               if (booksState !== "undefined" && booksState !== BooksStateEnum.Finished) {
                                    listView.model.addBookByIndex(0, insertId, dialog.author, dialog.title, false);
                               }
                           });
            })
        }
    }
}
