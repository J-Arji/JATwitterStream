//
//  TweetTableViewCell.swift
//  TwitterStream
//
//  Created by javad Arji on 4/9/22.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    // MARK: - property

    private lazy var tweetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupUI() {
        self.backgroundColor = .white
        self.accessoryType = .none
        self.selectionStyle = .none
        contentView.addSubview(tweetLabel)
        tweetLabel.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
    }
  
    public func set(data: TweetInterface) {
        tweetLabel.text = data.text
    }
}
