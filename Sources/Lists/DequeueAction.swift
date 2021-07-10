/**
 * Lists
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

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
        let identifier = reuseIdentifier(for: Cell.self)
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    }
    
    private func registerCellIfNeeded<Cell: UICollectionViewCell>(_: Cell.Type) {
        let identifier = reuseIdentifier(for: Cell.self)
        guard reuseIdentifiers.update(with: identifier) == nil else { return }
        collectionView.register(Cell.self, forCellWithReuseIdentifier: identifier)
    }
    
    private func reuseIdentifier<Cell: UICollectionViewCell>(for cellType: Cell.Type) -> String {
        String(describing: Cell.self)
    }
}
