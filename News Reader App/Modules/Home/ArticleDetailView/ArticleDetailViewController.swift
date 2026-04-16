//
//  ArticleDetailViewController.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit
import Kingfisher

protocol ArticleDetailDelegate: AnyObject {
    func didUpdateBookmark()
}

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var articleSubContainer: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var article_publisher: UILabel!
    @IBOutlet weak var article_published_date: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var artileContent: UITextView!
    @IBOutlet weak var thumbImage: UIImageView!
    weak var delage:ArticleDetailDelegate?
    
    @IBOutlet weak var bookmarkBtn: UIButton!
    var viewModel: ArticleDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBookmarkUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        styleUI()
    }
    
    private func styleUI() {
           articleImage.layer.cornerRadius = 12
           articleImage.clipsToBounds = true

           thumbImage.layer.cornerRadius = thumbImage.frame.height / 2
           thumbImage.clipsToBounds = true

           articleSubContainer.layer.cornerRadius = 12
           articleSubContainer.layer.borderColor = UIColor(hex: "EEEEEE").cgColor
           articleSubContainer.layer.borderWidth = 1
       }
    
    
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let  urlString = viewModel.url
           
           let title = viewModel.titleText
        
        guard   let url = URL(string: urlString) else {
            return
        }
           
           let items: [Any] = [title, url]
           
           let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
           
           // iPad fix
           if let popover = activityVC.popoverPresentationController {
               popover.sourceView = self.view
               popover.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
               popover.permittedArrowDirections = []
           }
           
           present(activityVC, animated: true)
    }
    @IBAction func bookmarkBtn(_ sender: UIButton) {
        let isSaved = viewModel.toggleBookmark()

                let imageName = isSaved ? "bookmark.circle.fill" : "bookmark.circle"
                sender.setImage(UIImage(systemName: imageName), for: .normal)

                showToast(message: isSaved ? "Article Saved" : "Article Removed Successfully")
        self.delage?.didUpdateBookmark()
           
    }
    
    // MARK: - Bookmark UI
        private func updateBookmarkUI() {
            let isSaved = viewModel.isBookmarked()
            let imageName = isSaved ? "bookmark.fill" : "bookmark"
            bookmarkBtn.setImage(UIImage(systemName: imageName), for: .normal)
           
        }

    
   
    private func bindData() {
           articleTitle.text = viewModel.titleText
           article_publisher.text = viewModel.publisherText
           article_published_date.text = viewModel.dateText
           artileContent.text = viewModel.contentText

           articleImage.kf.setImage(
               with: viewModel.mainImageURL,
               placeholder: UIImage(systemName: "photo"),
               options: [.transition(.fade(0.3)), .cacheOriginalImage]
           )

           thumbImage.kf.setImage(
               with: viewModel.thumbImageURL,
               placeholder: UIImage(systemName: "photo"),
               options: [.transition(.fade(0.3)), .cacheOriginalImage]
           )
       }

    
}
