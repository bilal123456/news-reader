//
//  BookmarkViewController.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//

import UIKit

class BookmarkViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var bookmarks: [BookmarkArticleModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        loadBookmarks()
    }
    
    
    func updateUI() {
        if bookmarks.isEmpty {
            tableView.setEmptyView(
                title: "No Saved Items",
                message: "Save articles  you want to see again.",
                image: UIImage(systemName: "bookmark")
            )
        } else {
            tableView.restore()
        }
        
        tableView.reloadData()
    }
    func loadBookmarks() {
        bookmarks = CoreDataManager.shared.fetchArticles()
        tableView.reloadData()
        updateUI()
    }
    

    
}

extension BookmarkViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookmarkTableViewCell
        cell.configure(article: bookmarks[indexPath.row], tag: indexPath.row)
        cell.bookmarkBtn.addTarget(self, action: #selector(handleRemoveBookmark), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetail: ArticleDetailViewController = ArticleDetailViewController.instantiate(appStoryboard: .main)
        articleDetail.viewModel = ArticleDetailViewModel(bookmark: bookmarks[indexPath.row])
       // articleDetail.article = viewModel.article(at: indexPath.row)
        self.navigationController?.pushViewController(articleDetail,animated:true)
    }
    
    @objc func handleRemoveBookmark(sender : UIButton) {
        CoreDataManager.shared.deleteArticle(id: bookmarks[sender.tag].id)
        showToast(message:"Article Removed Successfully")
        loadBookmarks()
        
    }
    
    
}
