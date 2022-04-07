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
        AF.session.getAllTasks { (tasks) in
            tasks.forEach {$0.cancel() }
        }
    }
    
    
    func request<T: Codable>(_ endpoint: URLRequestConvertible) -> Observable<T>{
        if !isConnectOnEthernetOrWiFi {
            //            return Observable.error(ClientError.noNetworkConnectivity)
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
                            observer.onError(ClientError.unKnownError(detail: error.errorDescription ?? "error occurred"))
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

enum ClientError: Error {
    
    typealias RawValue = String
    
    case noNetworkConnectivity
    case decodeJsonError
    case connectionTimeout
    case unKnownError(detail: String)
}
