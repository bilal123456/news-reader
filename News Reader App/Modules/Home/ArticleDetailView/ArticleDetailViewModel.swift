//
//  ArticleDetailViewModel.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//




import Foundation
import UIKit

class ArticleDetailViewModel {

    private let article: Article

    init(article: Article) {
        self.article = article
    }

    // MARK: - UI Data Bindings
    var titleText: String {
        article.title ?? ""
    }

    var publisherText: String {
        article.byline ?? ""
    }

    var dateText: String {
        article.publishedDate ?? ""
    }

    var contentText: String {
        article.abstract ?? ""
    }

    var mainImageURL: URL? {
        URL(string: article.media?.first?.mediaMetadata?.last?.url ?? "")
    }

    var thumbImageURL: URL? {
        URL(string: article.media?.first?.mediaMetadata?.first?.url ?? "")
    }

    var articleID: Int {
        article.id
    }

    // MARK: - Bookmark Logic
    func isBookmarked() -> Bool {
        CoreDataManager.shared.isBookmarked(id: article.id)
    }

    func toggleBookmark() -> Bool {
        if isBookmarked() {
            CoreDataManager.shared.deleteArticle(id: article.id)
            return false
        } else {
            CoreDataManager.shared.saveArticle(article: article)
            return true
        }
    }
}
