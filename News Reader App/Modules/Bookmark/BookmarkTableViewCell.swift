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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(article: BookmarkArticleModel, tag: Int) {
        bookmarkBtn.tag = tag
        containerView.applyCardStyle()
        img.setImage(urlString: article.imageURL)
        title.text = article.title
        article_publisher.text = article.byline
        artile_publised_date.attributedText = .calendarText(date: article.publishedDate)
        img.layer.cornerRadius = 12
        img.clipsToBounds = true
        selectionStyle = .none
    }
}
