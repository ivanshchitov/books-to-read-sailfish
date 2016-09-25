#ifndef BOOKLISTMODEL_H
#define BOOKLISTMODEL_H

#include <QObject>
#include <QSqlQueryModel>

class BookListModel : public QSqlQueryModel
{
    Q_OBJECT
public:
    enum Roles {
        ID = Qt::UserRole + 1,
        AUTHOR,
        TITLE,
        FINISHED
    };

    explicit BookListModel(QObject *paren = 0);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    const static char* COLUMN_NAMES[];

public slots:
    void updateModel();
    int getId(int row);
};

#endif // BOOKLISTMODEL_H
