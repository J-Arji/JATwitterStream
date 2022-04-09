//
//  APIClient.swift
//  TwitterStream
//
//  Created by javad Arji on 4/7/22.
//

import Alamofire

protocol APIClient {
    func request<T>(_: URLRequestConvertible, completion: @escaping (Result<T, ClientError>) -> Void) where T: Decodable, T: Encodable
    func requestStream<T>(_: URLRequestConvertible, completion: @escaping (Result<T, ClientError>) -> Void) where T: Decodable, T: Encodable
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
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        let sessionManager = Session(configuration: config)
        self.sessionManager = sessionManager
    }
    
    private func cancelTask() {
        sessionManager.cancelAllRequests()
    }
    
    
    
    func request<T: Codable>(_ endpoint: URLRequestConvertible, completion: @escaping (Result<T, ClientError>) -> Void) {
        guard let urlRequest = try? endpoint.asURLRequest() else {
            completion(.failure(ClientError.custom(detail: "have problem")))
            return
        }
        let request = sessionManager.request(urlRequest)

        request
            .validate()
            .cURLDescription {
                debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                print($0)
                debugPrint("-----------------------------------------------------------")
            }
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(model):
                    completion(.success(model))
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(.failure(ClientError.parser(detail: error.localizedDescription)))
                }
            }

    }
    
    func requestStream<T>(_ endpoint: URLRequestConvertible, completion: @escaping (Result<T, ClientError>) -> Void) where T : Decodable, T : Encodable {
        if !isConnectOnEthernetOrWiFi {
            completion(.failure(ClientError.noNetworkConnectivity))
        }
        cancelTask()
        
        self.sessionManager.streamRequest(endpoint)
            .validate()
            .cURLDescription {
                debugPrint("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
                print($0)
                debugPrint("-----------------------------------------------------------")
            }
        
            .responseStreamDecodable(of: T.self) { stream in
                switch stream.event {
                case let .stream(result):
                    switch result {
                    case let .success(value):
                        completion(.success(value))

                    case let .failure(error):
                        completion(.failure(ClientError.custom(detail: error.localizedDescription)))

                    }
                case let .complete(completion):
                    print(completion)                    
                }
            }
    }
}

