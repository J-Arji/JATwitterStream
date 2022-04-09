//
//  Error.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation


/** `ClientError` is the error type result returned by App. It encompasses a few different types of errors, each with their own associated reasons.
 
 - noNetworkConnectivity:  When error not found network conection
 - connectionTimeout: when error did not take long time respone
 - parser:   When error occurs while parsing data
 - custom:   When error doesn't fall in either of the above error type
 */

enum ClientError: Error {
    
    typealias RawValue = String
    
    case noNetworkConnectivity
    case parser(detail: String)
    case connectionTimeout
    case custom(detail: String)
}
extension ClientError {
    var description: String {
        switch self {
        case .noNetworkConnectivity:
            return "no network connectivity"
            
        case .connectionTimeout:
            return "connection Timeout"
            
        case let .parser(detail):
            return detail
            
        case let .custom( detail):
            return detail
        }
    }
}

