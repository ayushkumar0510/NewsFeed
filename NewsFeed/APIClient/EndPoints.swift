//
//  EndPoints.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    
    case json = "application/json"
    case form = "multipart/form-data"
}

enum EndPoints : APIRouteConfiguration {
    
    
    var path: String {
        return ""
    }
    
    case getNewsFeed
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        
        switch self {
        case .getNewsFeed:
            return .get
        }
    }
    
    // MARK: - Path
    var queryParams : [URLQueryItem]? {
        
        switch self {
        case .getNewsFeed :
            return [
                URLQueryItem(name :  "q", value :  "tesla"),
                URLQueryItem(name :  "from", value : "2021-04-30"),
                URLQueryItem(name :  "sortBy", value : "publishedAt"),
                URLQueryItem(name :  "apiKey", value :  "6c764468992a4f638d755cb90f5b8819")
            ]
        }
        
    }
    // MARK: - Parameters
    var parameters: Parameters? {
        
        switch self {
        case .getNewsFeed :
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.BASE_URL.asURL()
        var mURLComponent =  URLComponents(url: url, resolvingAgainstBaseURL: false)
        mURLComponent?.queryItems = queryParams
        var urlRequest = URLRequest(url:(mURLComponent?.url)!)
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.form.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        return urlRequest
    }
}

