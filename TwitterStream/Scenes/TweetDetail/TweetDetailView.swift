//
//  TweetDetailView.swift
//  TwitterStream
//
//  Created by javad Arji on 4/11/22.
//

import UIKit
import PanModal

class TweetDetailView: UIViewController, ModalProtocol {
    
    // MARK: - Properties
    private var viewModel: TweetDetailViewModel?
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(600)
    }
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Lifecycle
    init(viewModel: TweetDetailViewModel ) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = nil
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        descriptionLabel.text = viewModel?.tweet.text

        
    }
    
    private func setupUI() {
        view.addSubview(descriptionLabel)
        descriptionLabel.centerInSuperview()
        descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
    }


}
