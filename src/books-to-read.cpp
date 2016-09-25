#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include "databasemanager.h"
#include "booklistmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication* app = SailfishApp::application(argc, argv);
    QQuickView* view = SailfishApp::createView();

    DatabaseManager databaseManager;
    databaseManager.connectToDatabase();
    databaseManager.insertBook("asdasdad", "dasdasd", false);

    BookListModel *bookListModel = new BookListModel();
    QQmlEngine* engine = view->engine();
    engine->rootContext()->setContextProperty("bookListModel", bookListModel);
    engine->rootContext()->setContextProperty("databaseManager", &databaseManager);

    view->setSource(SailfishApp::pathTo("qml/books-to-read.qml"));
    view->showFullScreen();
    QObject::connect(view->engine(), &QQmlEngine::quit, app, &QGuiApplication::quit);
    return app->exec();
}
