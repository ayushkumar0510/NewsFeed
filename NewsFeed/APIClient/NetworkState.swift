//
//  NetworkState.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import Foundation
import Alamofire

struct NetworkState {
    
    var isConnected: Bool {
        // isReachable checks for wwan, ethernet, and wifi, if
        // you only want 1 or 2 of these, the change the .isReachable
        // at the end to one of the other options.
        //return false
        return NetworkReachabilityManager(host: "www.apple.com")!.isReachable
    }
}
