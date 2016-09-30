import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import org.fruct.yar 1.0

Item {
    property string booksTableName: "books";
    property string authorField: "author";
    property string titleField: "title";
    property string finishedField: "finished";

    property var database;

    Component.onCompleted: {
        database = LocalStorage.openDatabaseSync("books-to-read", "1.0");
        database.transaction(function(tx) {
            tx.executeSql("CREATE TABLE IF NOT EXISTS " + booksTableName + "(
                id INTEGER PRIMARY KEY AUTOINCREMENT,"
                + authorField + " TEXT NOT NULL, "
                + titleField + " TEXT NOT NULL, "
                + finishedField + " INTEGER NOT NULL)");
        });
    }

    function create(author, title, finished) {
        database.transaction(function(tx) {
            tx.executeSql("INSERT INTO " + booksTableName + "("
                          + authorField + ", " + titleField + ", " + finishedField
                          + ") VALUES(?, ?, ?)", [author, title, finished ? 1 : 0]);
        });
    }

    function retrieveBooks(booksState, callback) {
        database = LocalStorage.openDatabaseSync("books-to-read", "1.0");
        database.readTransaction(function(tx) {
            var whereFinished = "";
            if (booksState === BooksStateEnum.ToRead) {
                whereFinished = " WHERE finished = 0";
            } else if (booksState === BooksStateEnum.Finished) {
                whereFinished = " WHERE finished = 1";
            }
            var result = tx.executeSql("SELECT * FROM " + booksTableName + whereFinished);
            callback(result.rows)
        });
    }

    function updateBookState(id, finished, callback) {
        database = LocalStorage.openDatabaseSync("books-to-read", "1.0");
        database.transaction(function(tx) {
            tx.executeSql("UPDATE " + booksTableName
                        + " SET finished = ? WHERE id = ?", [finished, id]);
        });
    }

    function deleteBook(id) {
        database = LocalStorage.openDatabaseSync("books-to-read", "1.0");
        database.transaction(function(tx) {
            tx.executeSql("DELETE FROM " + booksTableName + " WHERE id = ?", [id]);
        });
    }
}

