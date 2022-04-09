//
//  DataSource.swift
//  TwitterStream
//
//  Created by javad Arji on 4/9/22.
//

import Foundation
import UIKit

protocol DataSource: AnyObject {
    associatedtype Data
    var data: DynamicValue<[Data]> { get set }
}

protocol Pageable {
    var isLoading: Bool { get set }
}

class TableDataSource<T>: NSObject, DataSource, Pageable {
    typealias Data = T
    var data = DynamicValue<[Data]>([])
    var isLoading: Bool = false
    var deleteItem: ((IndexPath)->Void)?
    var canDeleteRows: Bool = false
}

// - TableView Section Pattern

protocol Section {
    var title: String? { get }
    var items: [SectionItem] { get }
}

protocol SectionItem {
    var identifier: String { get }
    func cell(from tableView: UITableView) -> UITableViewCell
}

class CollectionDataSource<T>: NSObject, DataSource, Pageable {
    typealias Data = T
    var data = DynamicValue<[Data]>([])
    var isLoading: Bool = false
}
