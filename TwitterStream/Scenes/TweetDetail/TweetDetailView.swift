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
        return .maxHeight
    }
    
    
    // MARK: - Lifecycle
    init(viewModel: TweetDetailViewModel ) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        
    }


}
