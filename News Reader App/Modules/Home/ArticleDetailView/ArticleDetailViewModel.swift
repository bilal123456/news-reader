import Foundation
import UIKit

class ArticleDetailViewModel {

    // MARK: - Sources
    private let article: Article?
    private let bookmark: BookmarkArticleModel?

    // MARK: - Init (Home)
    init(article: Article) {
        self.article = article
        self.bookmark = nil
    }

    // MARK: - Init (Bookmark)
    init(bookmark: BookmarkArticleModel) {
        self.article = nil
        self.bookmark = bookmark
    }

    // MARK: - Helpers (Unified Access)

    private var title: String {
        article?.title ?? bookmark?.title ?? ""
    }

    private var byline: String {
        article?.byline ?? bookmark?.byline ?? ""
    }

    private var publishedDate: String {
        article?.publishedDate ?? bookmark?.publishedDate ?? ""
    }

    private var abstract: String {
        article?.abstract ?? bookmark?.abstract ?? ""
    }

    private var imageURLString: String? {
        article?.imageURL ?? bookmark?.imageURL
    }

    private var id: Int {
        article?.id ?? Int(bookmark?.id ?? 0)
    }

    // MARK: - UI Bindings

    var titleText: String { title }
    
    var url : String { article?.url ?? ""}

    var publisherText: String { byline }

    var dateText: String { publishedDate }

    var contentText: String { abstract }

    var mainImageURL: URL? {
        URL(string: imageURLString ?? "")
    }

    var thumbImageURL: URL? {
        URL(string: imageURLString ?? "")
    }

    var articleID: Int {
        id
    }

    // MARK: - Bookmark Logic (ONLY works for Article source)

    func isBookmarked() -> Bool {
        CoreDataManager.shared.isBookmarked(id: id)
    }

    func toggleBookmark() -> Bool {

        // If coming from bookmark screen → no toggle needed (optional safety)
        guard let article = article else {
            return true
        }

        if isBookmarked() {
            CoreDataManager.shared.deleteArticle(id: article.id)
            return false
        } else {
            CoreDataManager.shared.saveArticle(article: article)
            return true
        }
    }
}
