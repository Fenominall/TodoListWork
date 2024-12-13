//
//  TodoTaskTableViewCell.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    static let reuseIdentifier = "TodoItemTableViewCell"
    var checkmarkTappedHandler: ((Bool) -> Void)?
    
    private var isTaskCompleted: Bool = false {
        didSet {
            updateCheckmarkState()
            updateTodoTitleText()
        }
    }
    
    var isMenuActive: Bool = false {
        didSet {
            checkmarkButton.isHidden = isMenuActive
        }
    }
    // UI Elements
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var checkmarkButton: UIButton = {
        let checkmarkButton = UIButton(type: .system)
        checkmarkButton.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        config.imagePadding = 0
        config.imagePlacement = .leading
        config.contentInsets = .zero
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 24)
        checkmarkButton.configuration = config
        checkmarkButton.tintColor = .systemGray
        checkmarkButton.setImage(AppImages.circle.image, for: .normal)
        checkmarkButton.imageView?.contentMode = .scaleAspectFit
        checkmarkButton.addTarget(self, action: #selector(checkmarkTapped), for: .touchUpInside)
        return checkmarkButton
    }()
    
    private let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let taskDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionAndDatelabelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            taskDescriptionLabel, taskDateLabel
        ])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupBackgroundView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func checkmarkTapped() {
        isTaskCompleted.toggle()
        updateCheckmarkState()
        checkmarkTappedHandler?(isTaskCompleted)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(buttonContainer)
        buttonContainer.addSubview(checkmarkButton)
        containerView.addSubview(taskTitleLabel)
        containerView.addSubview(descriptionAndDatelabelsStackView)
        containerView.addSubview(divider)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            buttonContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            buttonContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            buttonContainer.widthAnchor.constraint(equalToConstant: 24),
            buttonContainer.heightAnchor.constraint(equalToConstant: 24),
            
            checkmarkButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            checkmarkButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            
            taskTitleLabel.leadingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: 10),
            taskTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            taskTitleLabel.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            
            descriptionAndDatelabelsStackView.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 8),
            descriptionAndDatelabelsStackView.leadingAnchor.constraint(equalTo: taskTitleLabel.leadingAnchor),
            descriptionAndDatelabelsStackView.trailingAnchor.constraint(equalTo: taskTitleLabel.trailingAnchor),
            
            divider.topAnchor.constraint(equalTo: descriptionAndDatelabelsStackView.bottomAnchor, constant: 12),
            divider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    // MARK: - Helpers
    private func updateCheckmarkState() {
        let imageName = isTaskCompleted ? AppImages.checkMarkCircle.image : AppImages.circle.image
        checkmarkButton.tintColor = .systemGray
        let checkMarkButtonColor: UIColor = isTaskCompleted ? .systemYellow : .systemGray
        checkmarkButton.tintColor = checkMarkButtonColor
        checkmarkButton.setImage(imageName, for: .normal)
    }
    
    private func applyTextAttributes(for completed: Bool) -> [NSAttributedString.Key: Any] {
        return completed ? [.strikethroughStyle: NSUnderlineStyle.single.rawValue] : [:]
    }
    
    private func updateTodoTitleText() {
        let text = taskTitleLabel.text ?? ""
        let attributedText = NSAttributedString(
            string: text,
            attributes: applyTextAttributes(for: isTaskCompleted)
        )
        taskTitleLabel.attributedText = attributedText
        let textColor: UIColor = isTaskCompleted ? .secondaryLabel : .label
        taskTitleLabel.textColor = textColor
    }
    
    private func setupBackgroundView() {
        let roundedBackgroundView = UIView()
        roundedBackgroundView.backgroundColor = .systemBackground
        roundedBackgroundView.layer.cornerRadius = 15
        roundedBackgroundView.layer.masksToBounds = true
        self.backgroundView = roundedBackgroundView
    }
}

// MARK: - Cell Configuration
extension TodoItemTableViewCell {
    func configure(
        with data: TodoItemFeedViewModel,
        checkmarkTappedHandler: @escaping (Bool) -> Void
    ) {
        self.checkmarkTappedHandler = checkmarkTappedHandler
        taskTitleLabel.text = data.title
        taskDescriptionLabel.text = data.description
        taskDateLabel.text = dateConvertedToDMYString(date: data.createdAt)
        isTaskCompleted = data.isCompleted
        
        updateCheckmarkState()
        updateTodoTitleText()
    }
}
