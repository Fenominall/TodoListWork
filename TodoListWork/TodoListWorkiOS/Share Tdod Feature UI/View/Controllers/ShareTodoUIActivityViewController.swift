//
//  TodoShareController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/18/24.
//

import UIKit
import TodoListWork

public final class ShareTodoUIActivityViewController: UIActivityViewController {
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
        super.init(activityItems: [viewModel], applicationActivities: nil)
        self.excludedActivityTypes = excludedActivityTypes
    }
}
