//
//  BookmarkViewModel.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//


import Foundation

final class BookmarkViewModel {

    private var items: [BookmarkArticleModel] = []

    var numberOfItems: Int {
        return items.count
    }

    func article(at index: Int) -> BookmarkArticleModel {
        return items[index]
    }

    func loadBookmarks() {
        items = CoreDataManager.shared.fetchArticles()
        print("item count bookmark is \(items.count)")
    }

    func deleteBookmark(at index: Int) {
        let id = items[index].id
        CoreDataManager.shared.deleteArticle(id: id)
        items.remove(at: index)
    }

    func isEmpty() -> Bool {
        return items.isEmpty
    }
}
