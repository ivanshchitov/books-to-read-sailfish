import QtQuick 2.0

ListModel {
    id: bookListModel

    function addBook(id, author, title, finished) {
        append({
                   id: id,
                   author: author,
                   title: title,
                   finished: finished
               });
    }
}
