# Lists 🧻

Tired of configuring table views and collection views, confirming to delegates and data sources? Introducing Lists, a reusable generic list view controller built on top of `UICollectionViewController`.

## Installation

Lists is distributed using [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your Package.swift manifest:

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/lucamegh/Lists", from: "1.0.0")
    ],
    ...
)
```

## Usage

```swift
ListViewController(cellType: ArticleCell.self, items: articles) { cell, article in
    cell.viewModel = ArticleViewModel(article: article)
}
```

That's really it, but it doesn't stop there. You can optionally customize list view controllers by providing a custom `UICollectionViewLayout`.

```swift
ListViewController(layout: ArticleGridLayout(), cellType: ArticleCell.self, items: articles) { cell, article in
    cell.viewModel = ArticleViewModel(article: article)
}
```

Let's see how to dequeue different cell types:

```swift
enum Post {

    case text(TextPost)
    
    case image(ImagePost)
}

ListViewController(items: posts) { dequeue, indexPath, post in
    switch post {
        case .text(let post):
            let cell = dequeue(TextPostCell.self, for: indexPath)
            cell.viewModel = TextPostViewModel(post: post)
            return cell
        case .image(let post):
            let cell = dequeue(ImagePostCell.self, for: indexPath)
            cell.viewModel = ImagePostViewModel(post: post)
            return cell
    }
}
```
Thanks to `DequeueAction` there's no need to preregister your cells. You just have to dequeue them.

You can also create list view controllers with a publisher that emits an array of values. `ListViewController` will do an animated refresh as soon as new items are emitted.

```swift
let recipes = cookbook.recipes().replaceError(with: []).eraseToAnyPublisher()

ListViewController(cellType: RecipeCell.self, items: recipes) { cell, recipe in
    cell.configure(with: recipe)
}
```
