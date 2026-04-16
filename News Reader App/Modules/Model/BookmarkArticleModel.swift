//
//  BookmarkArticleModel.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//


struct BookmarkArticleModel {
    let id: Int
    let title: String
    let byline: String
    let publishedDate: String
    let abstract: String
    let imageURL: String
}

extension BookmarkArticleModel {
    func toArticle() -> Article {
        return Article(
            uri: "",
            url: "",
            id: id,
            assetId: 0,
            source: "",
            publishedDate: publishedDate,
            updated: nil,
            section: "",
            subsection: nil,
            nytdsection: "",
            type: "",
            title: title,
            abstract: abstract,
            byline: byline,
            desFacet: nil,
            orgFacet: nil,
            perFacet: nil,
            geoFacet: nil,
            media: nil
        )
    }
}

