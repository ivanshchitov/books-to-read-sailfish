# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = books-to-read

CONFIG += sailfishapp

SOURCES += \
    src/books-to-read.cpp

OTHER_FILES += qml/books-to-read.qml \
    qml/cover/CoverPage.qml \
    rpm/books-to-read.changes.in \
    rpm/books-to-read.spec \
    rpm/books-to-read.yaml \
    translations/*.ts \
    books-to-read.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n console

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/books-to-read-de.ts

DISTFILES += \
    qml/pages/MainPage.qml \
    qml/pages/EditBookDialog.qml \
    qml/persistence/BooksDao.qml \
    qml/persistence/BookListModel.qml \
    qml/pages/BooksPage.qml \
    qml/AddBookPullDownMenu.xml \
    qml/menu/AddBookPullDownMenu.qml

HEADERS += \
    bookstateenum.h

QT += sql
