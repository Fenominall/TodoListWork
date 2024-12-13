//
//  AddEditTodoItemViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import UIKit

public final class AddEditTodoItemViewController: UIViewController {
    
    // MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 28)
        textField.tintColor = .systemYellow
        textField.textColor = .label
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = "Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.tintColor = .systemYellow
        textView.textColor = .label
        textView.backgroundColor = .clear
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setDelegates()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeFirstResponder()
    }
        
    // MARK: - Helpers
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(containerView)
        containerView.addSubview(titleTextField)
        containerView.addSubview(dateLabel)
        containerView.addSubview(contentTextView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            // Title TextField
            titleTextField.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            // Date Label
            dateLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            // Content TextView
            contentTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            contentTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}

// MARK: - UITextFieldDelegate
extension AddEditTodoItemViewController: UITextFieldDelegate {
    // Automatically focus the titleTextField
    private func makeFirstResponder() {
        titleTextField.becomeFirstResponder()
    }
    
    private func setDelegates() {
        titleTextField.delegate = self
    }
    
    //    # Function to return false if the input in UITextFiled is " " or "    ".
    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if (string == " " || string == "    ") {
            return false
        }
        return true
    }
    
    // Dismiss keyboard when touching in any part of the view.
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //    // Dismiss/Hide the KeyBoard.
    //    /// - Parameter textField: UITextField
    //    /// - Returns: resignFirstResponder()
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            contentTextView.becomeFirstResponder() // Move focus to contentTextView
        }
        return true
    }
}

