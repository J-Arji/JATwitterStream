//
//  JASearchBar.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//


import UIKit

class JASearchBarView: UIView {
    private lazy var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        return searchBar
    }()

    public var keyword: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }

    private func setUpViews() {
        // search bar has 8px padding from right and left 12 + 8 = 20
        searchBar.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        
    
        backgroundColor = .black
        searchBar.tintColor = .red
    }
}

extension JASearchBarView: UITextFieldDelegate {
    
}

