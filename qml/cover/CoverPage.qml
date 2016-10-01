import QtQuick 2.0
import Sailfish.Silica 1.0
import '../persistence'

CoverBackground {

    BooksDao {id: booksDao}

    Label {
           id: coverTitleLabel
           wrapMode: Text.Wrap
           y: parent.height / 5
           anchors {
               left: parent.left
               right: parent.right
               margins: Theme.paddingLarge
           }
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           text: qsTr("Books to read")
       }
       Label {
           id: lastAddedBookLabel
           anchors.top: coverTitleLabel.bottom
           width : parent.width
           wrapMode: Text.Wrap
           font.pixelSize: Theme.fontSizeLarge
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
       }
       Component.onCompleted: update()

       function update() {
           booksDao.retrieveLastAddedBook(function(lastAddedBook) {
               console.log(lastAddedBook)
               var coverTitle = qsTr("Books to read");
               var lastAddedBookTitle = "";
               if (lastAddedBook !== undefined) {
                   coverTitle = qsTr("Last added:");
                   lastAddedBookTitle = "\"" + lastAddedBook.title + "\"" + qsTr(" by ") + lastAddedBook.author;
               }
               coverTitleLabel.text = coverTitle;
               lastAddedBookLabel.text = lastAddedBookTitle;
           });
       }
}
