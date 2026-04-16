//
//  BookmarkViewController.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//

import UIKit

extension Notification.Name {
    static let bookmarkUpdated = Notification.Name("bookmarkUpdated")
}


class BookmarkViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let viewModel = BookmarkViewModel()
    weak var delegate:ArticleDetailDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func loadData() {
        viewModel.loadBookmarks()
        updateUI()
        tableView.reloadData()
    }

    private func updateUI() {
        if viewModel.isEmpty() {
            tableView.setEmptyView(
                title: "No Saved Items",
                message: "Save articles you want to see again.",
                image: UIImage(systemName: "bookmark")
            )
        } else {
            tableView.restore()
        }
    }
    deinit {
            NotificationCenter.default.removeObserver(self)
    }
}

extension BookmarkViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! BookmarkTableViewCell

        let article = viewModel.article(at: indexPath.row)
        cell.configure(article: article, tag: indexPath.row)

        cell.bookmarkBtn.tag = indexPath.row
        cell.bookmarkBtn.addTarget(self, action: #selector(handleRemoveBookmark), for: .touchUpInside)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let articleDetail: ArticleDetailViewController =
            ArticleDetailViewController.instantiate(appStoryboard: .main)

        let article = viewModel.article(at: indexPath.row).toArticle()
        articleDetail.viewModel = ArticleDetailViewModel(article:  article)

        navigationController?.pushViewController(articleDetail, animated: true)
    }

    @objc func handleRemoveBookmark(sender: UIButton) {
        viewModel.deleteBookmark(at: sender.tag)
        tableView.reloadData()
        updateUI()
        NotificationCenter.default.post(
                name: .bookmarkUpdated,
                object: nil
            )
        showToast(message: "Article Removed Successfully")
    }
}

