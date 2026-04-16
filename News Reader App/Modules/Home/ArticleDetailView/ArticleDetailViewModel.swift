import Foundation
import UIKit

class ArticleDetailViewModel {
    
    // MARK: - Sources
    private let article: Article?
    // MARK: - Init (Home)
    init(article: Article) {
        self.article = article
    }
    // MARK: - Helpers (Unified Access)
    
    private var title: String {
        article?.title ?? ""
    }
    private var byline: String {
        article?.byline  ?? ""
    }
    private var publishedDate: String {
        article?.publishedDate ?? ""
    }
    private var abstract: String {
        article?.abstract ?? ""
    }
    private var imageURLString: String? {
        article?.imageURL
    }
    private var id: Int {
        article?.id ?? 0
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
    func isBookmarked() -> Bool {
        CoreDataManager.shared.isBookmarked(id: id)
    }
    
    func toggleBookmark() -> Bool {
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
