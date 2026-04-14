//
//  ArticleDetailViewModel.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit


class ArticleDetailViewModel {
    
    private let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var title: String {
        return article.title ?? "No Title"
    }
    
    var publisher: String {
        return article.byline ?? "Unknown"
    }
    
    var publishedDate: String {
        return article.publishedDate ?? ""
    }
    
    var content: String {
        return article.abstract ?? "No Content Available"
    }
    
    var imageURL: URL? {
        return URL(string: article.media?.first?.mediaMetadata?.last?.url ?? "")
    }
    
    var thumbnailURL: URL? {
        return URL(string: article.media?.first?.mediaMetadata?.first?.url ?? "")
    }
}
