//
//  TweetDetailView.swift
//  TwitterStream
//
//  Created by javad Arji on 4/11/22.
//

import UIKit
import PanModal

class TweetDetailView: UIViewController, ModalProtocol {
    
    private var viewModel: TweetDetailViewModel?
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(400)
    }
    
    init(viewModel: TweetDetailViewModel ) {
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.viewModel = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
