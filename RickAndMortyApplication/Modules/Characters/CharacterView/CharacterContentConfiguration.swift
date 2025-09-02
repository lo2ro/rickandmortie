//
//  CharacterContentConfiguration.swift
//  RickAndMortyApplication
//
//  Created by Toshpulatova Lola on 25.08.2025.
//

import UIKit
import Kingfisher

struct CharacterContentConfiguration: UIContentConfiguration {
    let model: CharacterModel

    func makeContentView() -> any UIView & UIContentView {
        CharacterContentView(configuration: self)
    }

    func updated(for state: any UIConfigurationState) -> CharacterContentConfiguration {
        self
    }
}

final class CharacterContentView: UIView, UIContentView {

    private var contentConfiguration: CharacterContentConfiguration

    var configuration: UIContentConfiguration {
        get { contentConfiguration }
        set {
            guard let newConfiguration = newValue as? CharacterContentConfiguration else { return }
            contentConfiguration = newConfiguration
            update(with: contentConfiguration.model)
        }
    }

    private func update(with model: CharacterModel) {
        titleLabel.text = model.name

        // Загрузка картинки из API
        if let url = URL(string: model.image) {
            characterImageView.kf.setImage(
                with: url,
                placeholder: UIImage(systemName: "person.circle.fill"),
                options: [
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ]
            )
        }
    }

    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray // Плейсхолдер пока нет картинки
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Initialization
    init(configuration: CharacterContentConfiguration) {
        self.contentConfiguration = configuration
        super.init(frame: .zero)
        setupView()
        addSubviews()
        addConstraints()
        update(with: configuration.model) // Сразу обновляем данные
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .clear // Прозрачный фон основной вью
    }

//    private func update(with model: CharacterModel) {
//        titleLabel.text = model.name
//
//        // Здесь будет загрузка картинки (пока плейсхолдер)
//        // Для реального проекта добавь:
//        // characterImageView.kf.setImage(with: URL(string: model.image))
//        // или используй другую библиотеку для загрузки изображений
//    }

    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(titleLabel)
    }

    private func addConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Container View
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),

            // Character Image
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            characterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor), // Квадратная картинка

            // Title Label
            titleLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
}

