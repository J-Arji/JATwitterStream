//
//  APIClient.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Alamofire
import RxSwift

protocol APIClient {
    func request<T: Codable>(_ endpoint: URLRequestConvertible) -> Observable<T>
}

class APIClientImp: APIClient {
    
    // MARK: Properties
    private let sessionManager: Session
    var isConnectOnEthernetOrWiFi: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    // MARK: Lifecycle
    required init() {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 15
        config.headers = .default
        let sessionManager = Session(configuration: config)
        self.sessionManager = sessionManager
    }
    
    private func cancelTask() {
        sessionManager.cancelAllRequests()
    }
    
    
    func request<T: Codable>(_ endpoint: URLRequestConvertible) -> Observable<T>{
        if !isConnectOnEthernetOrWiFi {
            return Observable.error(ClientError.noNetworkConnectivity)
        }
        
        return  Observable<T>.create { [unowned self] observer -> Disposable in
            let request = self.sessionManager.streamRequest(endpoint)
            request
                .validate()
                .cURLDescription {
#if DEBUG
                    debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                    print($0)
                    debugPrint("-----------------------------------------------------------")
#endif
                }
                .responseStreamDecodable(of: T.self) { stream in
                    switch stream.event {
                    case let .stream(result):
                        switch result {
                        case let .success(value):
                            print(value)
                            observer.onNext(value)
                        case let .failure(error):
                            print(error)
                            observer.onError(ClientError.custom(detail: error.errorDescription ?? "error occurred"))
                        }
                    case let .complete(completion):
                        print(completion)
                    }
                    
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}


/** `NVError` is the error type result returned by App. It encompasses a few different types of errors, each with their own associated reasons.
 
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

