
import UIKit

enum ViewState {
    case loading
    case success
    case empty
    case error(String)
}


final class ArticleViewModel {

    private let repository: ArticleRepository

    private(set) var articles: [Article] = []
    private(set) var filteredArticles: [Article] = []

    var isSearching: Bool = false

    var state: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {
                self.onStateChange?(self.state)
            }
        }
    }

    var onStateChange: ((ViewState) -> Void)?

    init(repository: ArticleRepository) {
        self.repository = repository
    }

    func loadArticles() {

        state = .loading

        repository.fetchArticles { [weak self] result in
            guard let self else { return }

            switch result {

            case .success(let articles):
                self.articles = articles
                self.filteredArticles = articles

                self.state = articles.isEmpty ? .empty : .success

            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }

    // MARK: - Search
    func search(query: String) {

        if query.isEmpty {
            isSearching = false
            filteredArticles = articles
        } else {
            isSearching = true
            filteredArticles = articles.filter {
                $0.title.lowercased().contains(query.lowercased()) ||
                $0.abstract.lowercased().contains(query.lowercased())
            }
        }

        state = (filteredArticles.count == 0) ? .empty : .success
    }

    func numberOfRows() -> Int {
        filteredArticles.count
    }

    func article(at index: Int) -> Article {
        filteredArticles[index]
    }
}
