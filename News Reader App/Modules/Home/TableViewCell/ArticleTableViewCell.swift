//
//  ArticleTableViewCell.swift
//  News Reader App
//
//  Created by Apple  on 14/04/2026.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var bookmarkimg: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var article_publisher: UILabel!
    @IBOutlet weak var artile_publised_date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(article: Article) {
        containerView.applyCardStyle()

        img.setImage(urlString: article.imageURL)

        title.text = article.title
        article_publisher.text = article.byline
        artile_publised_date.attributedText = .calendarText(date: article.publishedDate ?? "")

        img.layer.cornerRadius = 12
        img.clipsToBounds = true

        selectionStyle = .none

        let isBookmarked = CoreDataManager.shared.isBookmarked(id: article.id)
        bookmarkimg.image = UIImage(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
    }

}
