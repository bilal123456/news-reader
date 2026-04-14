//
//  Environment.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit


enum Environment {
    case development
    case staging
    case production

    var baseURL: String {
        switch self {
        case .development:
            return "https://api.nytimes.com"
        case .staging:
            return "https://api.nytimes.com"
        case .production:
            return "https://api.nytimes.com"
        }
    }

    var apiKey: String {
        switch self {
        case .development:
            return "JKfzQMYKJim0FAQcNxinmKX2iBA9ofDuP824GNFiV5GuIZF1"
        case .staging:
            return "JKfzQMYKJim0FAQcNxinmKX2iBA9ofDuP824GNFiV5GuIZF1"
        case .production:
            return "JKfzQMYKJim0FAQcNxinmKX2iBA9ofDuP824GNFiV5GuIZF1"
        }
    }
}

enum ArticleEndpoint {
    case mostViewed(days: Int)

    func url(environment: Environment) -> URL? {
        switch self {
        case .mostViewed(let days):
            let urlString = "\(environment.baseURL)/svc/mostpopular/v2/mostviewed/all-sections/\(days).json?api-key=\(environment.apiKey)"
            return URL(string: urlString)
        }
    }
}
