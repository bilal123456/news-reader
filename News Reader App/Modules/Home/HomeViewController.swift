//
//  HomeViewController.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: ArticleViewModel!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        tableView.showsVerticalScrollIndicator = false
        
        setupViewModel()
        bindViewModel()
        tableView.restore()
        viewModel.loadArticles()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkChanged),
            name: .connectivityStatus,
            object: nil
        )
    }
    
    
    @objc func networkChanged() {
        if NetworkMonitor.shared.isConnected {
            tableView.restore()
            viewModel.loadArticles()      // Fresh data fetch karo
        } else {
            viewModel.loadArticles()      // ✅ Cache se load karne ki koshish karo
        }
    }
    
    func setupViewModel() {
        let api = APIService()
        let repo = ArticleRepository(api: api)
        self.viewModel = ArticleViewModel(repository: repo)
    }
    
    
    func bindViewModel() {

        viewModel.onStateChange = { [weak self] state in
            guard let self else { return }

            self.activityView.isHidden = true

            switch state {

            case .loading:
                self.activityView.isHidden = false

            case .success:
                self.tableView.restore()  // ✅ Yeh ensure karta hai empty view remove ho
                self.tableView.reloadData()

            case .empty:
                self.tableView.reloadData()  // ✅ Pehle reload karo (0 rows)
                self.tableView.setEmptyView( // Phir empty view set karo
                    title: "No Results",
                    message: "No articles found for \"\(self.searchbar.text ?? "")\"",
                    image: UIImage(systemName: "magnifyingglass")
                )

            case .error(let message):
                self.showOfflineBanner(false)
                self.tableView.setEmptyView(
                    title: "Error",
                    message: message,
                    image: UIImage(systemName: "exclamationmark.triangle")
                )
            }
        }
    }
    
    private func showOfflineBanner(_ show: Bool) {
        if show {
            searchbar.placeholder = "⚠️ Offline – showing cached articles"
        } else {
            searchbar.placeholder = "Search articles..."
        }
    }
    
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleTableViewCell
        cell.configure(article: viewModel.article(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetail: ArticleDetailViewController = ArticleDetailViewController.instantiate(appStoryboard: .main)
        articleDetail.viewModel = ArticleDetailViewModel(article: viewModel.article(at: indexPath.row))
        self.navigationController?.pushViewController(articleDetail,animated:true)
    }
    
   
    
    
}
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
