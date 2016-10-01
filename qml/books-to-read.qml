import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "cover"

ApplicationWindow
{
    id: appWindow
    initialPage: Component {
        MainPage { }
    }
    cover: CoverPage { id: coverPage }
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All
}
