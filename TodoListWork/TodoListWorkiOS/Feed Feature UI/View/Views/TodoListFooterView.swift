//
//  TodoListFooterView.swift
//  TodoListWorkiOS
//
//  Created by Fenominall on 12/11/24.
//

import UIKit
import SnapKit

protocol TodoListFooterViewDelegate: AnyObject {
    func didTapAddNewTaskButton()
}

final class TodoListFooterView: UIView {
    weak var delegate: TodoListFooterViewDelegate?
    
    // MARK: - Subviews
    private let footerViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let homeBarViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let itemsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "7 Задач"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addNewItemButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.image = AppImages.squareAndPencil.image
        config.baseForegroundColor = .systemYellow
        config.baseBackgroundColor = .clear
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.imagePadding = 0
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        button.configuration = config
        button.isUserInteractionEnabled = true
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        setupView()
        setConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        setupView()
        setConstraints()
        setupActions()
    }
    
    // MARK: - Setup Actions
    private func setupActions() {
        addNewItemButton.addTarget(self, action: #selector(addNewNoteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addNewNoteButtonTapped() {
        delegate?.didTapAddNewTaskButton()
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        addSubview(footerViewContainer)
        addSubview(homeBarViewContainer)
        footerViewContainer.addSubview(itemsCountLabel)
        footerViewContainer.addSubview(addNewItemButton)
    }
    
    private func setConstraints() {
        homeBarViewContainer.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        footerViewContainer.snp.makeConstraints {
            $0.height.equalTo(49)
            $0.bottom.equalTo(homeBarViewContainer.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        itemsCountLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(footerViewContainer.snp.center)
        }
        
        addNewItemButton.snp.makeConstraints {
            $0.centerY.equalTo(footerViewContainer.snp.centerY)
            $0.trailing.equalTo(footerViewContainer.snp.trailing).offset(-20)
        }
    }
}
