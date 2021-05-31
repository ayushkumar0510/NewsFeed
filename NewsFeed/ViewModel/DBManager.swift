//
//  DBManager.swift
//  NewsFeed
//
//  Created by Ayush on 31/05/21.
//

import UIKit
import CoreData

let contentTableName = "Articles"

class DBManager: NSObject {

    @available(iOS 10.0, *)
    static func getAppDelegate() -> AppDelegate? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate
        } else {
            return nil
        }
    }

    @available(iOS 10.0, *)
    static func getManagedContext()-> NSManagedObjectContext? {
        let context = getAppDelegate()?.persistentContainer.viewContext
        return context
    }

    @available(iOS 10.0, *)
    static func saveContext() {
        getAppDelegate()?.saveContext()
    }
    
    //Add contentID to DB
    @available(iOS 10.0, *)
    static func addContentIdToDB(arrayList: [Article]?) {
        
        let managedContext = DBManager.getManagedContext()
        let request = NSFetchRequest<NSManagedObject>(entityName: contentTableName)
        request.returnsObjectsAsFaults = false
        
        for item in arrayList ?? [Article]() {
            
            let entity = NSEntityDescription.entity(forEntityName: contentTableName, in: managedContext!)
            let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)
            newUser.setValue(item.author, forKey: "author")
            newUser.setValue(item.title, forKey: "title")
            newUser.setValue(item.articleDescription, forKey: "descriptionNews")
            newUser.setValue(item.url, forKey: "url")
            newUser.setValue(item.urlToImage, forKey: "urlToImage")
            newUser.setValue(item.publishedAt, forKey: "publishedAt")
            newUser.setValue(item.content, forKey: "content")
        }
        
        DBManager.saveContext()
        print(request)
    }
    
    //Get number of opened content
    @available(iOS 10.0, *)
    static func getArticleFromDB() -> [Article] {
        
        var articleData = [Article]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            
            let request = NSFetchRequest<NSManagedObject>(entityName: contentTableName)
            let result = try context.fetch(request)
            
            for i in 0..<result.count {
                var  article = Article()
                article.author = result[i].value(forKey: "author") as? String
                article.title = result[i].value(forKey: "title") as? String
                article.articleDescription = result[i].value(forKey: "descriptionNews") as? String
                article.url = result[i].value(forKey: "url") as? String
                article.urlToImage = result[i].value(forKey: "urlToImage") as? String
                article.publishedAt = result[i].value(forKey: "publishedAt") as? String
                article.content = result[i].value(forKey: "content") as? String
                articleData.append(article)
            }
            print(result)
        } catch {
            print("Failed")
        }
        return articleData
    }
}
