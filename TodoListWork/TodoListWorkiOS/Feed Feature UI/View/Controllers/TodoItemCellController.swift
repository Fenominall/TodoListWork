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
        print("TEST TAPPED")
        selection()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        releaseCellForReuse()
    }
        
    private func releaseCellForReuse() {
        cell = nil
    }
    
    public func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        // Hide the checkmark button when the menu is active
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.cell?.isMenuActive = true
        }
        
        return UIContextMenuConfiguration(
            identifier: indexPath as NSIndexPath,
            previewProvider: nil
        ) { _ in
            let edit = UIAction(
                title: "Редатировать",
                image: AppImages.squareAndPencil.image
            ) { _ in
                // Handle edit
            }
            
            let share = UIAction(
                title: "Поделиться",
                image: AppImages.squareAndArrowUp.image
            ) { _ in
                // Handle share
            }
            
            let delete = UIAction(
                title: "Удалить",
                image: AppImages.trash.image,
                attributes: .destructive
            ) { [weak self] _ in
                self?.deletion()
            }
            
            return UIMenu(title: "", children: [edit, share, delete])
        }
    }

    public func tableView(_ tableView: UITableView, willEndContextMenuInteraction configuration: UIContextMenuConfiguration, animator: (any UIContextMenuInteractionAnimating)?) {
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.cell?.isMenuActive = false
        }
    }
}
