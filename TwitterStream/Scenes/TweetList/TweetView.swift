//
//  TweetView.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import UIKit
import RxSwift
import RxCocoa


class TweetView: UIViewController {
    //MARK: -
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TweetTableViewCell.self)
        tableView.allowsMultipleSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var viewModel: TweetViewModel {
        return TweetViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRuls()
        // Do any additional setup after loading the view.
    }
    

}
