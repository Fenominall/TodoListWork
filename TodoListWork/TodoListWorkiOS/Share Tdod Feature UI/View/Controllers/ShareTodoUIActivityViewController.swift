//
//  TodoShareController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/18/24.
//

import UIKit
import TodoListWork

public final class ShareTodoUIActivityViewController: UIActivityViewController {
    private let viewModel: ShareTodoItemViewModel
    
    public init(
        viewModel: ShareTodoItemViewModel,
        excludedActivityTypes: [UIActivity.ActivityType]? = [
            .airDrop,
            .postToTwitter,
            .postToWeibo,
            .message,
            .mail,
            .print,
            .saveToCameraRoll,
            .addToReadingList,
        ]
    ) {
        self.viewModel = viewModel
        super.init(activityItems: [viewModel.content], applicationActivities: nil)
        self.excludedActivityTypes = excludedActivityTypes
    }
}
