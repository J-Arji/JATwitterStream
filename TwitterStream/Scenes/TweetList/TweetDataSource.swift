//
//  TweetDataSource.swift
//  TwitterStream
//
//  Created by javad Arji on 4/8/22.
//

import RxDataSources

enum TableViewSection {
    case CustomeSection(items: [TweetInterface])
    
}


extension TableViewSection: SectionModelType {
    var items: [TweetInterface] {
        switch self {
        case let .CustomeSection(data):
            return data
        }
    }
    
    typealias Item = TweetInterface
    
    init(original: Self, items: [Self.Item]) {
        self = original
    }
}

struct TweetDataSource {
    typealias DataSource = RxTableViewSectionedReloadDataSource
    
    static func dataSource() -> DataSource<TableViewSection> {
        return .init(configureCell: { dataSource, tableView, indexPath, item -> UITableViewCell in
            let cell = UITableViewCell()
            //            cell.viewModel = IntermediateItemViewModel(itemModel: item)
            return cell
        })
    }
}
