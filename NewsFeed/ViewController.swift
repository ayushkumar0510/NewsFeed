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
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.newsList.articles?.count != 0 {
            UIHelper.animate(count: self.newsList.articles?.count ?? 0, tableView: self.tableViewNews)
        }
    }
    
    func setUpView() {
        
        navigationItem.title = "Headlines"
        tableViewNews.delegate = self
        tableViewNews.dataSource = self
        getNewsData()
    }
    
    func getNewsData() {
        
        UIHelper.showProgressHud(inView: self.view)
        
        if(NetworkState().isConnected) {
            
            apiManager.getNewsList { (res) in
                
                UIHelper.hideProgressHud()
                self.newsList = res.value ?? NewsResponse()
                if UserDefaults.standard.isFirstTime() == false {
                    DBManager.addContentIdToDB(arrayList: self.newsList.articles)
                    UserDefaults.standard.setFirstTime()
                }
                DBManager.addContentIdToDB(arrayList: self.newsList.articles)
                self.tableViewNews.reloadData()
                UIHelper.animate(count: self.newsList.articles?.count ?? 0, tableView: self.tableViewNews)
                print(res)
            }
        } else {
            
            UIHelper.hideProgressHud()
            let article = DBManager.getArticleFromDB()
            self.newsList.articles = article
            self.tableViewNews.reloadData()
            UIHelper.animate(count: self.newsList.articles?.count ?? 0, tableView: self.tableViewNews)
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.selectionStyle = .none
        cell.lblNews.text = newsList.articles?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataArticle = newsList.articles?[indexPath.row]
        
        let vc = storyboard?.instantiateViewController(identifier: "DetailVC") as! DetailViewController
        vc.data = dataArticle ?? Article()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

