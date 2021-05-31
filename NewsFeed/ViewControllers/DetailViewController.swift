//
//  DetailViewController.swift
//  NewsFeed
//
//  Created by Ayush on 31/05/21.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var data = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView() {
        
        navigationItem.title = "NEWS Details"
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: "Image Icon"),
            transition: .fadeIn(duration: 0.3)
        )
        
        let modifyString = data.urlToImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: modifyString ?? "") {
            Nuke.loadImage(with: url, options: options, into: imgView)
        }
        
        lblDescription.text = data.articleDescription
        
    }
}
