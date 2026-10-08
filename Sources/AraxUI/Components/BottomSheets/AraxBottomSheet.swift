//
//  AraxBottomSheet.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import UIKit

class AraxBottomSheet: UIViewController {
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    init(image: UIImage?, title: String?, message: String?) {
        super.init(nibName: nil, bundle: nil)
        setupView()
        self.imageView.image = image
        self.titleLabel.text = title
        self.messageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dismissTapped() {
        dismiss(animated: true)
    }
}

extension AraxBottomSheet {
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            dismissButton.widthAnchor.constraint(equalToConstant: 32),
            dismissButton.heightAnchor.constraint(equalToConstant: 32)
        ])
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            verticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        ])

        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(messageLabel)
        verticalStackView.spacing = 12
    }
}
