//
//  SHRestClient.swift
//  NewsFeed
//
//  Created by Ayush on 30/05/21.
//

import Foundation
import Alamofire

class SHRestClient{
    
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
    @discardableResult
    private static func getRequest<T:Decodable>(route:APIRouteConfiguration, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        
        return AF.request(route)
            .responseJSON(completionHandler: { (response) in
                debugPrint(response.result)
            })
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                debugPrint(response.result)
                completion(response.result)
        }
        
    }
    
    static func login(email: String, password: String, completion:@escaping (Result<User>)->Void) {
        postRequest(route: EndPoints.login(email: email, password: password), completion: completion)
    }
}
