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

enum EndPoints : APIRouteConfiguration{
    
    var path: String {
        return ""
    }
    
    case login(email: String, password: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .login    :
            return .get
        }
    }
    
    // MARK: - Path
    var queryParams : [URLQueryItem]? {
        switch self {
        case .login :
            return [URLQueryItem(name :  "route", value :  "openapi/customer/login")]
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login :
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
        
        
        print(urlRequest.url)
        return urlRequest
    }
}
