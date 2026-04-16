//
//  ArticleRepositoryMock.swift
//  News Reader App
//
//  Created by Apple  on 16/04/2026.
//


import Foundation

final class ArticleRepositoryMock: ArticleRepositoryProtocol {

    var result: Result<[Article], Error>?
    var cached: [Article]?

    var fetchCalled = false

    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {

        fetchCalled = true

        if let result = result {
            completion(result)
            return
        }

        if let cached = cached {
            completion(.success(cached))
            return
        }

        completion(.failure(NSError(
            domain: "MockError",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "No mock data set"]
        )))
    }
}
