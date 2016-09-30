#ifndef BOOKSTATEENUM
#define BOOKSTATEENUM

#include <QObject>

class BooksStateEnum : public QObject
{
    Q_OBJECT
    Q_ENUMS(BooksState)
public:
    enum BooksState {
        ToRead = 1,
        Finished = 2,
        All = 3
    };

    BooksStateEnum(QObject *parent = 0) : QObject(parent) {}
};

#endif

