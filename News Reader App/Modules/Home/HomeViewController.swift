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
        self.activityView.isHidden = false
        setupViewModel()
        bindViewModel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.viewModel.loadArticles()
        })
      
        tableView.showsVerticalScrollIndicator = false
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
                self.tableView.restore()
                self.tableView.reloadData()

            case .empty:
                self.tableView.setEmptyView(
                    title: "No Data",
                    message: "No articles found.",
                    image: UIImage(systemName: "tray")
                )

            case .error(let message):
                self.tableView.setEmptyView(
                    title: "Error",
                    message: message,
                    image: UIImage(systemName: "exclamationmark.triangle")
                )
            }
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
        return 120
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
