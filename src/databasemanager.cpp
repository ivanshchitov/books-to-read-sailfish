#include "databasemanager.h"
#include <QDebug>

/**
 * @brief The constructor.
 * @param parent The parent QObject.
 */
DatabaseManager::DatabaseManager(QObject *parent) : QObject(parent)
{
}

/**
 * @brief The destructor.
 */
DatabaseManager::~DatabaseManager() {
}

/**
 * @brief DataBase::connectToDataBase
 */
void DatabaseManager::connectToDatabase()
{
    this->openDatabase();
    this->createBooksTable();
}

/**
 * @brief Opens the database.
 */
void DatabaseManager::openDatabase()
{
    database = QSqlDatabase::addDatabase("QSQLITE");
    database.setHostName(DATABASE_HOSTNAME);
    database.setDatabaseName(DATABASE_NAME);
    if (database.open()) {
        qDebug() << "QDEBUG: Database is opened";
    } else {
        qDebug() << "QDEBUG: Database is not opened";
    }
}

/**
 * @brief Closes the database.
 */
void DatabaseManager::closeDataBase()
{
    database.close();
}

/**
 * @brief Creates the "books" table.
 */
void DatabaseManager::createBooksTable()
{
    QSqlQuery query;
    if (query.exec("CREATE TABLE IF NOT EXISTS " BOOKS_TABLE_NAME
                     "(id INTEGER PRIMARY KEY AUTOINCREMENT, "
                     AUTHOR_FIELD " TEXT NOT NULL, "
                     TITLE_FIELD " TEXT NOT NULL, "
                     FINISHED_FIELD "INTEGER NOT NULL);")) {
        qDebug() << "QDEBUG: Table is created";
    } else {
        qDebug() << "QDEBUG: Table is not created";
    }
}

/**
 * @brief Inserts the book data to the database.
 * @param author The book author.
 * @param title The book title.
 * @param finished True if reading of this book is already finished, false - otherwise.
 */
void DatabaseManager::insertBook(const QString &author, const QString &title, const bool finished)
{
    QSqlQuery query;
    query.prepare("INSERT INTO " BOOKS_TABLE_NAME " (" AUTHOR_FIELD ", " TITLE_FIELD ", " FINISHED_FIELD ") "
                  "VALUES (:author, :title, :finished);");
    query.bindValue(":author", author);
    query.bindValue(":title", title);
    query.bindValue(":finished", finished ? 1 : 0);
    if (query.exec()) {
        qDebug() << "QDEBUG: Inserted";
    } else {
        qDebug() << "QDEBUG: Not inserted " + query.executedQuery();
        qDebug() << "QDEBUG: Not inserted " + query.lastError().text();
    }
}

/**
 * @brief Removes a book by the given id from the database.
 * @param id The record id.
 */
void DatabaseManager::removeBookById(const int id)
{
    QSqlQuery query;
    query.prepare("DELETE FROM " BOOKS_TABLE_NAME " WHERE id = :id;");
    query.bindValue(":id", id);
    query.exec();
}
