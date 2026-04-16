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
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        let url = URL(string: article.imageURL ?? "")
        

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
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "calendar")

        let attachmentString = NSAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " \(article.publishedDate)")

        let finalString = NSMutableAttributedString()
        finalString.append(attachmentString)
        finalString.append(textString)

        artile_publised_date.attributedText = finalString
        img.layer.cornerRadius = 12
        img.clipsToBounds = true
        selectionStyle = .none
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.05
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 8
        containerView.layer.borderColor = UIColor(hex:"#EEEEEE").cgColor
        containerView.layer.borderWidth = 1
        bookmarkimg.image = UIImage(systemName: CoreDataManager.shared.isBookmarked(id: article.id) ? "bookmark.fill" : "bookmark") 
        
        
        
    }

}
