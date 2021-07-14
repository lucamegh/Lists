/**
 * Lists
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit
import Combine

public final class ListViewController<Item: Hashable>: UICollectionViewController {
    
    public var delegate = ListViewControllerDelegate<Item>()
    
    private lazy var dataSource = ListViewControllerDataSource(
        collectionView: collectionView,
        cellProvider: cellProvider
    )
    
    private var cancellable: AnyCancellable?

    private let cellProvider: CellProvider
    
    public init(
        layout: UICollectionViewLayout? = nil,
        items: AnyPublisher<[Item], Never>,
        cellProvider: @escaping CellProvider
    ) {
        self.cellProvider = cellProvider
        super.init(collectionViewLayout: layout ?? .default)
        self.collectionView.backgroundColor = .systemBackground
        cancellable = items.sink { [dataSource] items in
            dataSource.replaceItems(with: items)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        item(for: indexPath).map(delegate.didSelectItem)
    }
    
    public override func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        item(for: indexPath).flatMap(delegate.contextMenuConfiguration)
    }
}

public extension ListViewController {
    
    func item(for indexPath: IndexPath) -> Item? {
        dataSource.itemIdentifier(for: indexPath)
    }
    
    func indexPath(for item: Item) -> IndexPath? {
        dataSource.indexPath(for: item)
    }
}

public extension ListViewController {
    
    typealias CellProvider = (DequeueAction, IndexPath, Item) -> UICollectionViewCell
}

public extension ListViewController {
    
    convenience init(
        layout: UICollectionViewLayout? = nil,
        items: [Item],
        cellProvider: @escaping CellProvider
    ) {
        self.init(
            layout: layout,
            items: Just(items).eraseToAnyPublisher(),
            cellProvider: cellProvider
        )
    }
    
    convenience init<Cell: UICollectionViewCell>(
        layout: UICollectionViewLayout? = nil,
        cellType: Cell.Type,
        items: AnyPublisher<[Item], Never>,
        configureCell: @escaping (Cell, Item) -> Void
    ) {
        self.init(layout: layout, items: items) { dequeue, indexPath, item in
            let cell = dequeue(Cell.self, for: indexPath)
            configureCell(cell, item)
            return cell
        }
    }
    
    convenience init<Cell: UICollectionViewCell>(
        layout: UICollectionViewLayout? = nil,
        cellType: Cell.Type,
        items: [Item],
        configureCell: @escaping (Cell, Item) -> Void
    ) {
        self.init(
            layout: layout,
            cellType: Cell.self,
            items: Just(items).eraseToAnyPublisher(),
            configureCell: configureCell
        )
    }
}
