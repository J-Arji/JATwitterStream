//
//  NetworkRouter.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Alamofire
import Foundation


protocol NetworkRouter: URLRequestConvertible {
    var baseURLString: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers:  HTTPHeaders?{ get }
    var params: [String: Any]? { get }
    var encoding: ParameterEncoding {get }
    func asURLRequest() throws -> URLRequest
    
}

extension NetworkRouter {
    
    var baseURLString: String {
        return Config.shared.baseAddress

    }

    // Add Rout method here
    var method: HTTPMethod {
        return .get
    }

    // Set APIs'Rout for each case
    var path: String {
        return ""
    }

    // Set header here
    var headers: HTTPHeaders? {
        return [:]
    }
    // Set encoding for each APIs
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

    // Return each case parameters
    var params: [String: Any]? {
        return [:]
    }

    
    
    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLString.appending(path))
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers?.dictionary
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        if method == .get {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
        } else {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params ?? [:], options: .prettyPrinted)
        }
        return urlRequest
    }

}

