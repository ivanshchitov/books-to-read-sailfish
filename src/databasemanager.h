#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSql>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlDatabase>
#include <QFile>
#include <QDate>
#include <QVariant>

#define DATABASE_HOSTNAME "books-to-read"
#define DATABASE_NAME "books-to-read.sqlite"

#define BOOKS_TABLE_NAME "books"
#define AUTHOR_FIELD "author"
#define TITLE_FIELD "title"
#define FINISHED_FIELD "finished"

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = 0);
    ~DatabaseManager();
    void connectToDatabase();

private:
    QSqlDatabase database;

    void openDatabase();
    void closeDataBase();
    void createBooksTable();

public slots:
    void insertBook(const QString &author, const QString &title, const bool finished);
    void removeBookById(const int id);
};

#endif // DATABASEMANAGER_H
