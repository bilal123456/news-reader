//
//  Article.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit

struct Article: Codable {
    let uri: String
    let url: String
    let id: Int
    let assetId: Int
    let source: String
    let publishedDate: String
    let updated: String?
    let section: String
    let subsection: String?
    let nytdsection: String
    let type: String
    let title: String
    let abstract: String
    let byline: String?
    let desFacet: [String]?
    let orgFacet: [String]?
    let perFacet: [String]?
    let geoFacet: [String]?
    let media: [Media]?

    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetId = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case type
        case title
        case abstract
        case byline
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
    }
}

struct Media: Codable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let mediaMetadata: [MediaMeta]?

    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMeta: Codable {
    let url: String
    let format: String?
    let height: Int?
    let width: Int?
}

extension Article {

    var imageURL: String? {
        return media?
            .first?
            .mediaMetadata?
            .last?
            .url
    }
}
