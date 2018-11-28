# UICollectionView Crash

This project demonstrates a UICollectionView crash when using `performBatchUpdates` and in the updates implicitly remove a header. The crash can be observed by running the application, and removing the last item via bar button "Delete". Alternatively the UITests can be run which will trigger the crash immediately. The problem stems from the code in `collectionView(_:layout:referenceSizeForHeaderInSection:)` which returns `CGSize.zero` in case there are no items. So when deleting the last item in `performBatchUpdates`, the UICollectionView will also call that delegate method, and when the header changes from a positive height to 0, it will crash on Xcode 9 on iOS 11.4 simulator, or freeze for 15 seconds (!!) on Xcode 10 beta 6 on iOS 12 simulator.

## Update for iOS 12.1

The issue seems to be fixed in iOS 12.1.
