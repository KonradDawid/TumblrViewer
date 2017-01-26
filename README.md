# Explanatory notes:
Posts of type other than photo or regular (and UnavailableTableViewCell) were introduced to allow proper pagination when type is not specified in request to API.

Rendering of html in UITableView/UICollectionView is always problematic (mostly due to performance reasons and dynamic height of UIWebView) and should be avoided. However, in order to make most of the content visible, e.g. images, indentation, in this project html is rendered in cells. Still, much can be improved as reqards layout, height, reuse of those cells, reloading only particular cells, etc.
