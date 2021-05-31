//
//  UserDefaultExtension.swift
//  NewsFeed
//
//  Created by Ayush on 31/05/21.
//

import Foundation

enum UserDefalultStorageKeys : String {
    
    case isFirstTime
}
extension UserDefaults {
        
    func setFirstTime()  {
        set(true, forKey: UserDefalultStorageKeys.isFirstTime.rawValue)
    }
    
    func isFirstTime() -> Bool {
        return UserDefaults().bool(forKey: UserDefalultStorageKeys.isFirstTime.rawValue)
    }
}
