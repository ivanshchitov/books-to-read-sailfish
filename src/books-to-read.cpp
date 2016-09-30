#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include "bookstateenum.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<BooksStateEnum>("org.fruct.yar", 1, 0, "BooksStateEnum");
    return SailfishApp::main(argc, argv);
}
