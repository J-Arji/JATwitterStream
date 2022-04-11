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
        searchBar.returnKeyType = .done
        return searchBar
    }()

    public var keyword: ((String?) -> Void)?
    
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
        // search bar has 8px padding from right and left
        searchBar.fillSuperview(padding: .init(top: 0, left: 8, bottom: 0, right: 8))
        
    
        backgroundColor = .black
        searchBar.tintColor = .red
    }
}

extension JASearchBarView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.keyword?(textField.text)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }

    
}
