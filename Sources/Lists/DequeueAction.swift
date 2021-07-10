/**
 * Lists
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit
import ReusableView

public class DequeueAction {
    
    private var reuseIdentifiers = Set<String>()
    
    private let collectionView: UICollectionView
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }
    
    public func callAsFunction<Cell: UICollectionViewCell>(_: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeue(Cell.self, for: indexPath)
    }
    
    private func dequeue<Cell: UICollectionViewCell>(_: Cell.Type, for indexPath: IndexPath) -> Cell {
        registerCellIfNeeded(Cell.self)
        return collectionView.dequeue(Cell.self, for: indexPath)
    }
    
    private func registerCellIfNeeded<Cell: UICollectionViewCell>(_: Cell.Type) {
        guard reuseIdentifiers.update(with: Cell.reuseIdentifier) == nil else { return }
        collectionView.register(Cell.self)
    }
}
