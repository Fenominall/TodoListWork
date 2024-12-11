//
//  ConfigureableCell.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit

protocol ConfigureableCell {
    associatedtype DataType
    
    func configure(with data: DataType)
}

protocol CellConfigurator {
    static var reuseIdentifier: String { get }
    
    func configure(cell: UIView)
    func register(_ tableView: UITableView)
}
