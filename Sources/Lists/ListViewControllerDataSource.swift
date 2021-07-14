/**
 * Lists
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

class ListViewControllerDataSource<Item: Hashable>: UICollectionViewDiffableDataSource<Int, Item> {
    
    private let collectionView: UICollectionView
    
    private let dequeue: DequeueAction
    
    init(
        collectionView: UICollectionView,
        cellProvider: @escaping ListViewController<Item>.CellProvider
    ) {
        self.collectionView = collectionView
        self.dequeue = DequeueAction(collectionView: collectionView)
        super.init(collectionView: collectionView) { [dequeue] _, indexPath, item in
            cellProvider(dequeue, indexPath, item)
        }
    }
    
    func replaceItems(with items: [Item], animatingDifferences: Bool = true) {
        let animatingDifferences = animatingDifferences && snapshot().indexOfSection(0) != nil
        let snapshot = makeSnapshot(with: items)
        apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func makeSnapshot(with items: [Item]) -> NSDiffableDataSourceSnapshot<Int, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        return snapshot
    }
}
