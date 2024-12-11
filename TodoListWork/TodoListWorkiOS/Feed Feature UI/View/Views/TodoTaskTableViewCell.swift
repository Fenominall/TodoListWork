//
//  TodoTaskTableViewCell.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit

class TodoTaskTableViewCell: UITableViewCell {
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
        contentView.addSubview(checkmarkButton)
        contentView.addSubview(taskTitleLabel)
        contentView.addSubview(descriptionAndDatelabelsStackView)
        contentView.addSubview(divider)
        
        NSLayoutConstraint.activate([
            checkmarkButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            taskTitleLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 6),
            taskTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            taskTitleLabel.centerYAnchor.constraint(equalTo: checkmarkButton.centerYAnchor),
            
            descriptionAndDatelabelsStackView.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 8),
            descriptionAndDatelabelsStackView.leadingAnchor.constraint(equalTo: taskTitleLabel.leadingAnchor),
            descriptionAndDatelabelsStackView.trailingAnchor.constraint(equalTo: taskTitleLabel.trailingAnchor),
            
            divider.topAnchor.constraint(equalTo: descriptionAndDatelabelsStackView.bottomAnchor, constant: 12),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    // MARK: - Configuration
    private func updateCheckmarkState() {
        let imageName = isTaskCompleted ? AppImages.checkMarkCircle.image : AppImages.circle.image
        checkmarkButton.tintColor = .systemGray
        let checkMarkButtonColor: UIColor = isTaskCompleted ? .systemYellow : .systemGray
        checkmarkButton.tintColor = checkMarkButtonColor
        checkmarkButton.setImage(imageName, for: .normal)
    }
    
    func configure(taskTitle: String, taskDescription: String, taskDate: String, isCompleted: Bool) {
        taskTitleLabel.text = taskTitle
        taskDescriptionLabel.text = taskDescription
        taskDateLabel.text = taskDate
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
