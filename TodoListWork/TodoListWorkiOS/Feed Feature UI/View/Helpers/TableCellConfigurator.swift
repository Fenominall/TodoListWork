//
//  TableCellConfigurator.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit

final class TableCellConfigurator<CellType: ConfigureableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: CellType.self)
    }
    
    private let item: DataType
    
    init(item: DataType) {
        self.item = item
    }
    
    func configure(cell: UIView) {
        guard let cell = cell as? CellType else { return }
        cell.configure(with: item)
    }
    
    func register(_ tableView: UITableView) {
        tableView.register(CellType.self, forCellReuseIdentifier: Self.reuseIdentifier)
    }
}
