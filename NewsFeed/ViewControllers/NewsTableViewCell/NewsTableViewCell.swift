//
//  NewsTableViewCell.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
