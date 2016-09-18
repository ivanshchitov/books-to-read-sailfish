import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: toReadPage

    SilicaListView {
        anchors.fill: parent
        header: PageHeader { title: qsTr("Finished") }
        model: 10
        delegate: ListItem {
            Column {
                Label {
                    text: qsTr("Book") + " " + (model.index + 1)
                    x: Theme.horizontalPageMargin
                    font.strikeout: model.index % 3 == 0 ? true : false
                }
                Label {
                    text: qsTr("Author") + " " + (model.index + 1)
                    x: Theme.horizontalPageMargin
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
            }
            menu: ContextMenu {
                MenuItem {
                    text: model.index % 3 == 0 ? qsTr("Mark as To Read") : qsTr("Mark as Finished")
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
