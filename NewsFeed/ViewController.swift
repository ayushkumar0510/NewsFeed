//
//  ViewController.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewNews: UITableView!
    
    var apiManager = APIManager()
    var newsList = NewsResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpView()
    }
    
    func setUpView() {
        
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
        getNewsData()
    }
    
    func getNewsData() {
        
        apiManager.getNewsList { (res) in
            self.newsList = res.value ?? NewsResponse()
            self.tableViewNews.reloadData()
            print(res)
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.lblNews.text = newsList.articles?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

