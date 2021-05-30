//
//  APIManager.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import Foundation
import UIKit
import Alamofire


enum SHDataResponse<Value>{
    case success(Value)
    case failure(Error)
    
    /// Initializes a `Result` from value or error. Returns `.failure` if the error is non-nil, `.success` otherwise.
    ///
    /// - Parameters:
    ///   - value: A value.
    ///   - error: An `Error`.
    init(value: Value, error: Error?) {
        if let error = error {
            self = .failure(error)
        } else {
            self = .success(value)
        }
    }
    
    /// Returns `true` if the result is a success, `false` otherwise.
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    /// Returns `true` if the result is a failure, `false` otherwise.
    public var isFailure: Bool {
        return !isSuccess
    }
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    /// Returns the associated error value if the result is a failure, `nil` otherwise.
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
    
}


class APIManager {
    
    static var newsList = NewsResponse()
    var isNetworkAvailable  = false
    
    func getNewsList(completion:@escaping (SHDataResponse<NewsResponse>)->Void) {
        
        if(NetworkState().isConnected){
            
            SHRestClient.getNewsFeed { response in
                switch response {
                case .success(let result):
                    APIManager.newsList = result
                    completion( SHDataResponse(value: result, error: nil))
                case .failure(let error):
                    completion( SHDataResponse(value: NewsResponse(), error: error))
                }
            }
        }
    }
}
