//
//  UIHelper.swift
//  NewsFeed
//
//  Created by Ayush on 31/05/21.
//

import Foundation
import UIKit
import JGProgressHUD

class UIHelper {
    
   fileprivate static var currentHud : JGProgressHUD!
    enum AletType {
        case success
        case error
        case info
    }
    static func getCurrentShownHud()-> JGProgressHUD?{
        return currentHud
    }
    
    static func showProgressHud(inView : UIView){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        
        hud.show(in:inView)
        currentHud = hud
       
    }
    
    
    static func showProgressHudWitnInfo(inView : UIView, info : String){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please Wait"
        hud.detailTextLabel.text = info
        hud.show(in:inView)
        currentHud = hud
        
    }
    
    static func hideProgressHud(){
        
        if let hud = currentHud{
            hud.dismiss()
            currentHud = nil
        }
        
    }
    
    static func animate(count : Int, tableView : UITableView) {
        
        let evenIndices = (0..<count).compactMap {
            
            return ($0 % 2 == 0) ? IndexPath(row: $0, section: 0) : nil
        }
        
        let oddIndices = (0..<count).compactMap {
            
            return ($0 % 2 == 0) ? nil : IndexPath(row: $0, section: 0)
        }
        
        let rightAnimation = TableViewAnimation.Cell.right(duration: 1.5)
        let leftAnimation = TableViewAnimation.Cell.left(duration: 1.5)
        tableView.animate(animation: rightAnimation, indexPaths: evenIndices, completion: nil)
        tableView.animate(animation: leftAnimation, indexPaths: oddIndices, completion: nil)
    }
    
}
