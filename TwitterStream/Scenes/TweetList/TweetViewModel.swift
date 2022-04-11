//
//  TweetViewModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation
import Alamofire

protocol ViewModelInterFace {
    var error:  DynamicValue<String?> { get set }
    var isLoading: DynamicValue<Bool?> { get set }
    func startLoading()
    func stopLoading()
    func show(message: String)
    func fetchData()
}

class TweetViewModel {
    private var service: FilterService
    public var text: String?{
        didSet {
            self.getRuls()
        }
    }
    private var dataSource: TableDataSource<TweetItem>
    public var error = DynamicValue<String?>(nil)
    public var isLoading = DynamicValue<Bool?>(nil)
    public var reload: (() -> Void)?
    public var reloadItems: ((_ row: Int) -> Void)?
    
    init(dataSource:TableDataSource<TweetItem>, service: FilterService = DependencyContainer.shared.services.search) {
        self.service = service
        self.dataSource = dataSource
    }
    
    
}

extension TweetViewModel {
    /**
     Check if there is a rule
     */
    public func getRuls() {
        self.dataSource.data.value = []
        self.startLoading()
        service.getRules { [self] result in
            switch result {
            case let .success(data):
                self.checkResult(with: data)
                print(data)
                
            case let .failure(error):
                self.show(message: error.localizedDescription)
            }
        }
    }
    
    private func checkResult(with rules: RulesResponseModel) {
        guard let rules = rules.data, !rules.isEmpty else {
            self.addRules()
            return
        }
        let rulesId =  rules.compactMap { $0.id }
        self.deleteRules(ids: rulesId)
        
    }
    
    /**
     Just remove the rule we used last time for stream in real time
     */
    private func deleteRules(ids: [String]) {
        service.deleteRules(with: ids) { [self] result in
            switch result {
            case  .success(_):
                self.addRules()
                
            case let .failure(error):
                self.show(message: error.localizedDescription)
                
            }
        }
        
    }
    /**
     add the rule for stream in real time
     */
    private func addRules(){
        guard let text = text else { return }
        service.addRule(keyword: text) { [self] result in
            DispatchQueue.main.async {
                self.stopLoading()
            }
            switch result {
            case .success(_):
                self.fetchData()
                
            case let .failure(error):
                self.show(message: error.localizedDescription)
            }
        }
    }
    
    /**
     send query for fetch data
     */
    private func filterTweet(completion: @escaping (TweetItem) -> Void) {
        service.fetch { result in
            switch result {
            case let .success(tweet):
                print(tweet)
                let tweetItems =  TweetItem.TweetCell(model: tweet.data)
                completion(tweetItems)
            case .failure(_):
                break
            }
        }
    }
}


extension TweetViewModel: ViewModelInterFace {
    
    internal func fetchData() {
        filterTweet { [weak self] tweet in
            guard let self = self else { return }
            self.dataSource.data.value.insert(tweet, at: 0)
            self.reload?()
        }
    }
    
    internal func startLoading() {
        self.isLoading.value = true
    }
    internal func stopLoading() {
        self.isLoading.value = false
    }
    internal func show(message: String) {
        self.error.value = message
    }
}
