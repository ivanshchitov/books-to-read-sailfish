#include "booklistmodel.h"
#include "databasemanager.h"

const char* BookListModel::COLUMN_NAMES[] = {
    "id",
    "author",
    "title",
    "finshed"
};

BookListModel::BookListModel(QObject *parent) : QSqlQueryModel(parent)
{
    this->updateModel();
}

/**
 * @brief Retrieves data from the model.
 * @param index The record index.
 * @param role The model role.
 * @return The QVariant with data.
 */
QVariant BookListModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole)
    {
        return QSqlQueryModel::data(index, role);
    } else {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
}

/**
 * @return The hash with role names.
 */
QHash<int, QByteArray> BookListModel::roleNames() const
{
    int idx = 0;
    QHash<int, QByteArray> roleNames;
    while(COLUMN_NAMES[idx]) {
        roleNames[Qt::UserRole + idx + 1] = COLUMN_NAMES[idx];
        idx++;
    }
    return roleNames;
}

/**
 * @brief Updates data in the model.
 */
void BookListModel::updateModel()
{
    this->setQuery("SELECT id, " AUTHOR_FIELD ", " TITLE_FIELD ", " FINISHED_FIELD " FROM " BOOKS_TABLE_NAME);
}

/**
 * @brief Retrieves the record id by the given ListView row.
 * @param row The row in ListView.
 * @return The record id.
 */
int BookListModel::getId(int row)
{
    return this->data(this->index(row, 0), ID).toInt();
}
