//
//  TodoItemCellController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import Foundation
import UIKit

public final class TodoItemCellController: NSObject {
    private(set) var viewModel: TodoItemFeedViewModel
    private var cell: TodoItemTableViewCell?
    private let selection: () -> Void
    private let deletion: () -> Void
    private let onCompletedStatusToggle: (TodoItemFeedViewModel) -> Void
    
    public init(
        viewModel: TodoItemFeedViewModel,
        selection: @escaping () -> Void,
        deletion: @escaping () -> Void,
        onCompletedStatusToggle: @escaping (TodoItemFeedViewModel) -> Void
    ) {
        self.viewModel = viewModel
        self.selection = selection
        self.deletion = deletion
        self.onCompletedStatusToggle = onCompletedStatusToggle
    }
}

extension TodoItemCellController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.configure(with: viewModel) { [weak self] isCompleted in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.isCompleted = isCompleted
            strongSelf.onCompletedStatusToggle(strongSelf.viewModel)
        }
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        releaseCellForReuse()
    }
        
    private func releaseCellForReuse() {
        cell = nil
    }
}
