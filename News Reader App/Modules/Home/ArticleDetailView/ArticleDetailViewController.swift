//
//  ArticleDetailViewController.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var articleSubContainer: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var article_publisher: UILabel!
    @IBOutlet weak var article_published_date: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var artileContent: UITextView!
    @IBOutlet weak var thumbImage: UIImageView!
    
   var   article: Article
    override func viewDidLoad() {
        super.viewDidLoad()
        configeData()
       
    }
    
    func configureData () {
        let articleImage = article.media?.first?.mediaMetadata?.last?.url ?? nil
        let articleImageUrl = articleImage?.mediaMetadata
    }
    
    
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookmarkBtn(_ sender: Any) {
    }
    func configeData () {
//        articleImage.image = viewModel.imageURL
//        thumbImage.image = viewModel.imageURL
        guard let viewModel = viewModel else {
               print("❌ ViewModel is nil")
               return
           }

        articleTitle.text = viewModel.title
        article_publisher.text = viewModel.publisher
        article_published_date.text = viewModel.publishedDate
        artileContent.text = viewModel.content
    }
    
}
