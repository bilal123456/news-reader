//
//  ArticleRepository.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//


import Foundation

protocol ArticleRepositoryProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
}

final class ArticleRepository : ArticleRepositoryProtocol {

    private let api: APIServiceProtocol
    private let environment: Environment
    private let cache: CacheServiceProtocol

    init(
        api: APIServiceProtocol,
        cache: CacheServiceProtocol = ArticleCacheService(),
        environment: Environment = .development
    ) {
        self.api = api
        self.cache = cache
        self.environment = environment
    }

    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {

        guard let url = ArticleEndpoint.mostViewed(days: 7).url(environment: environment) else {
            if let cached = cache.loadArticles(), !cached.isEmpty {
                completion(.success(cached))
            } else {
                completion(.failure(URLError(.badURL)))
            }
            return
        }

        api.request(url: url) { [weak self] (result: Result<NYTimesResponse, Error>) in
            guard let self else { return }

            switch result {

            case .success(let response):
                self.cache.saveArticles(response.results)
                completion(.success(response.results))

            case .failure(let error):
                if let cached = self.cache.loadArticles(), !cached.isEmpty {
                    completion(.success(cached))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}
