import QtQuick 2.0
import QtQuick.LocalStorage 2.0

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


    function retrieveAllBooks(callback) {
        database = LocalStorage.openDatabaseSync("books-to-read", "1.0");
        database.readTransaction(function(tx) {
            var result = tx.executeSql("SELECT * FROM " + booksTableName);
            callback(result.rows)
        });
    }
}

