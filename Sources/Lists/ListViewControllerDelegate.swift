/**
 * Lists
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import UIKit

public struct ListViewControllerDelegate<Item: Hashable> {
    
    public var didSelectItem: (Item) -> Void
    
    public var contextMenuConfiguration: (Item) -> UIContextMenuConfiguration?
    
    public init(
        didSelectItem: @escaping (Item) -> Void = { _ in },
        contextMenuConfiguration: @escaping (Item) -> UIContextMenuConfiguration? = { _ in nil }
    ) {
        self.didSelectItem = didSelectItem
        self.contextMenuConfiguration = contextMenuConfiguration
    }
}
