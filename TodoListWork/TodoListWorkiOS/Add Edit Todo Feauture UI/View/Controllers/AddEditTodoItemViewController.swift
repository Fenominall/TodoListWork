//
//  AddEditTodoItemViewController.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/13/24.
//

import UIKit

public final class AddEditTodoItemViewController: UIViewController {
    
    public var onSave: (() -> Void)?
    public var onViewDidLoad: (() -> Void)?
    
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
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.tintColor = .systemYellow
        textField.textColor = .secondaryLabel
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = datePicker
        textField.reloadInputViews()
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.tintColor = .secondaryLabel
        picker.backgroundColor = .clear
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        return picker
    }()
    
    private lazy var descriptionTextView: UITextView = {
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
        onViewDidLoad?()
        
        setupUI()
        setupConstraints()
        setDelegates()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeFirstResponder()
    }
        
    // MARK: - Actions
    @objc private func backButtonTapped() {
        onSave?()
    }
    
    @objc private func datePickerChanged(_ sender: UIDatePicker) {
        dateTextField.text = dateConvertedToDMYString(date: sender.date)
    }
    
    // MARK: - Helpers
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(containerView)
        containerView.addSubview(titleTextField)
        containerView.addSubview(dateTextField)
        containerView.addSubview(descriptionTextView)
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
            dateTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            dateTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            // Content TextView
            descriptionTextView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    // Does not work TODO
    private func setupBackButton () {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .systemYellow
    }
    
    public func updateUIwith(title: String, date: String, description: String?) {
        titleTextField.text = title
        dateTextField.text = date
        descriptionTextView.text = description
    }
}

// MARK: - UITextFieldDelegate
extension AddEditTodoItemViewController: UITextFieldDelegate {
    // MARK: - TextField Updates
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        // TODO
    }
    
    
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
            descriptionTextView.becomeFirstResponder() // Move focus to contentTextView
        }
        return true
    }
}

