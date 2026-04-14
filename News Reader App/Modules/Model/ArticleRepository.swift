//
//  ArticleRepository.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//


final class ArticleRepository {

    private let api: APIServiceProtocol
    private let environment: Environment

    init(api: APIServiceProtocol, environment: Environment = .development) {
        self.api = api
        self.environment = environment
    }

    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void) {

        guard let url = ArticleEndpoint.mostViewed(days: 7).url(environment: environment) else {
            return
        }

        api.request(url: url) { (result: Result<NYTimesResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}