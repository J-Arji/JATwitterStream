//
//  TweetDataSource.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import UIKit


class TweetDataSource: TableDataSource<TweetTableViewItem>, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         data.value[indexPath.row].cell(from: tableView, for: indexPath)
    }

    
}
enum TweetTableViewItem {
    case TweetCell(model: TweetInterface)
    
    func cell(from tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case let .TweetCell(items):
            let cell: TweetTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(data: items)
            return cell
        }
    }
    
    func itemValue() -> TweetInterface {
        switch self {
        case let .TweetCell(model: data):
            return data
        }
    }
}
