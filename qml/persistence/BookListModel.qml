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

    function updateBook(index, author, title, finished) {
        set(index, {author: author, title: title, finished: finished})
    }
}
