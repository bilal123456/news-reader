//
//  BookmarkTableViewCell.swift
//  News Reader App
//
//  Created by Apple  on 15/04/2026.
//

import UIKit
import Kingfisher

class BookmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var bookmarkBtn: UIButton!
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
    
    func configure(article: BookmarkArticleModel,tag:Int) {
        bookmarkBtn.tag = tag
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        let url = URL(string: article.imageURL)
        

        img.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        )
        title.text = article.title
        article_publisher.text = article.byline
        artile_publised_date.text = "📅 \(article.publishedDate) "
        img.layer.cornerRadius = img.frame.height / 2
        img.clipsToBounds = true
        selectionStyle = .none
        
        
        
    }
}
