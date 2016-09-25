import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: toReadPage

    SilicaListView {
        anchors.fill: parent
        header: PageHeader { title: qsTr("To Read") }
        model: bookListModel

        delegate: ListItem {
            Column {
                Label {
                    text: title
                    x: Theme.horizontalPageMargin
                }
                Label {
                    text: author
                    x: Theme.horizontalPageMargin
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Mark as Finished")
                }
                MenuItem {
                    text: qsTr("Edit")
                    onClicked: pageStack.push(Qt.resolvedUrl("EditBookDialog.qml"))
                }
                MenuItem {
                    text: qsTr("Delete")
                }
            }
        }
    }
}
