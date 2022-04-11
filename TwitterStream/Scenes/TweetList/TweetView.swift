//
//  TweetView.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import UIKit
class TweetView: UIViewController , NavigationProtocol {
  
    //MARK: -
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TweetTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.dataSource = dataSource
        tableView.delegate = self
        return tableView
    }()
    private lazy var searchView: JASearchBarView = {
        let view = JASearchBarView()
        view.backgroundColor = .lightGray
        return view
    }()
    private lazy var loadingView: LoadingView = {
        return LoadingView()
    }()
    
    
    private lazy  var viewModel: TweetViewModel = {
        let viewModel = TweetViewModel(dataSource: dataSource)
        return viewModel
    }()
    private lazy var dataSource = TweetDataSource()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindTableView()
        bindError()
        bindIndicatorView()
        bindTextField()
    }
    
    
    // MARK: - Bind ViewModel
    func bindTableView() {
        viewModel.reload = { [weak self] in
            self?.reload()
        }
        
        viewModel.reloadItems = { [weak self] row in
            self?.tableView.reloadData()
        }
        viewModel.present = { item in
            guard let tweet = item else { return }
            self.showDetailView(tweet: tweet)
        }
    }
    
    
    private func bindError() {
        viewModel.error.addObserver(self) { [weak self] value in
            guard let message = value else { return }
            self?.showErrorAlert(message: message)
        }
    }
    
    private func bindIndicatorView() {
        viewModel.isLoading.addAndNotify(observer: self) { [weak self] value in
            guard let isHidden = value else { return }
            if isHidden {
                self?.loadingView.startAnimating()
            } else {
                self?.loadingView.stopAnimating()
            }
        }
    }
    
    
    //MARK: - bindTextField
    private func bindTextField() {
        searchView.keyword = { [weak self] text in
            guard let text = text else { return }
            self?.viewModel.text = text
        }
    }
    
    // MARK: - Setups
    private func setupUI() {
        view.backgroundColor = .white
        tableView.dismissKeyboard()
        view.addSubview(searchView)
        view.addSubview(tableView)
        view.add(loading: loadingView)
        searchView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          leading: view.leadingAnchor,
                          bottom: tableView.topAnchor,
                          trailing: view.trailingAnchor,
                          padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        searchView.constrainHeight(constant: 40)
        tableView.anchor(top: nil,
                         leading: view.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    private func showDetailView(tweet: TweetInterface) {
        let viewModel = TweetDetailViewModel(tweet: tweet)
        let vc = TweetDetailView(viewModel: viewModel)
        self.presentModal(vc)
    }
}

extension TweetView {
    private func reload() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
        tableView.endUpdates()
    }
}

// MARK: - TableViewDelegate
extension TweetView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.itemSelected(index: indexPath.row)
    }
}
