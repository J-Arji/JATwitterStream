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
    var headers: HTTPHeaders? { get }
    var params: [String: Any]? { get }
    var url: URLConvertible { get }
    var encoding: ParameterEncoding {get }
    func asURLRequest() throws -> URLRequest
    
}

extension NetworkRouter {
    //    typealias ResultRouter<T: Codable> = Result<T, Error>
    
    var baseURLString: String {
        return Constants.BaseURLString

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
        return ["contentType": "application/json"]
    }

    // Set encoding for each APIs
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

    // Return each case parameters
    var params: [String: Any]? {
        return [:]
    }

    var url: URLConvertible {
        return baseURLString.appending(path)
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURLString.appending(path).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = headers?.dictionary
        urlRequest.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if method == .get {
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
            urlRequest.url = URL(string: urlRequest.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        } else {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params ?? [:], options: .prettyPrinted)
        }
        return urlRequest
    }
}

struct Constants {
    static let BaseURLString = "https://api.twitter.com/2/tweets/search/stream"
    static let rulesAPIEndPoint = "/rules"
    static let connectStreamAPIEndPoint = "?tweet.fields=created_at&expansions=author_id,geo.place_id&user.fields=created_at&place.fields=contained_within,country,full_name,geo,id,name,place_type"
    static let bearerToken = "Bearer Token"
}
