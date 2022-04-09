//
//  TweetViewModel.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import Foundation
import RxSwift
import RxCocoa

class TweetViewModel {
    private var service: FilterService
    public var isLoading = BehaviorRelay<Bool>(value: false)
    public var error = PublishRelay<String>()
    public let items = BehaviorSubject<[TableViewSection]>(value: [])
    private(set) var disposeBag = DisposeBag()
    private(set) var text: String? = "javad"
    
    init(service: FilterService = DependencyContainer.shared.services.search) {
        self.service = service
    }
    
}

extension TweetViewModel {
    
    public func getRuls() {
        self.isLoading.accept(true)
        service.getRules { [self] result in
//            guard let self = self else { return }
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
        print(rules)
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
            case let .success(data):
                print(data)
                self.addRules()

            case let .failure(error):
                self.show(message: error.localizedDescription)

            }
        }

    }
    
    private func addRules(){
        guard let text = text else { return }
        service.addRule(keyword: text) { [self] result in
            switch result {
            case .success(_):
                self.fetchTweet()

            case let .failure(error):
                self.show(message: error.localizedDescription)

            }
        }
    }
    
    public func fetchTweet() {
        service.fetch { [ self] result in
            switch result {
            case let .success(data):
                self.convertData(model: data)
            case let .failure(error):
                self.show(message: error.localizedDescription)

            }
        }

    }
    
    private func convertData(model: [FeedResponseModel]){
        let section = TableViewSection.CustomeSection(items: model.map { $0.feed })
        self.items.onNext([section])
    }
    
    private func stopLoading() {
        self.isLoading.accept(false)
    }
    private func show(message: String) {
        stopLoading()
        self.error.accept(message)
    }
}

