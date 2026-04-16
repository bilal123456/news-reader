//
//  NewsModel.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit


struct NYTimesResponse: Decodable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [Article]

    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}


