import QtQuick 2.0

ListModel {
    id: bookListModel

    function addBook(author, title, finished) {
        append({
                   author: author,
                   title: title,
                   finished: finished
               });
    }
}
