//
//  HomeViewController.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: ArticleViewModel!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        bindViewModel()
        viewModel.loadArticles()
    }
    
    func setupViewModel() {
        let api = APIService()
        let repo = ArticleRepository(api: api)
        self.viewModel = ArticleViewModel(repository: repo)
    }
    
    
    func bindViewModel() {

            viewModel.onUpdate = { [weak self] in
               print("Data update")
                guard let self = self else {return}
                self.tableView.reloadData()
            }

            viewModel.onError = { error in
                print("Data eror")
                print(error.localizedDescription)
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
       // articleDetail.article = viewModel.article(at: indexPath.row)
        self.navigationController?.pushViewController(articleDetail,animated:true)
    }
    
    
}
