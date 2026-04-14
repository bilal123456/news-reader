
import UIKit


final class ArticleViewModel {

    private let repository: ArticleRepository

    private(set) var articles: [Article] = []

    var onUpdate: (() -> Void)?
    var onError: ((Error) -> Void)?

    init(repository: ArticleRepository) {
        self.repository = repository
    }

    func loadArticles() {
        repository.fetchArticles { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let articles):
                self.articles = articles
                DispatchQueue.main.async {
                    self.onUpdate?()
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    self.onError?(error)
                }
            }
        }
    }

    func numberOfRows() -> Int {
        return articles.count
    }

    func article(at index: Int) -> Article {
        return articles[index]
    }
}
