//
//  EpisodesContenView.swift
//  RickAndMortyApplication
//
//  Created by Mitina Ekaterina on 22.08.2025.
//
import UIKit

struct EpisodesContentConfiguration: UIContentConfiguration {

    let model: EpisodeModel
    
    func makeContentView() -> any UIView & UIContentView {
        EpisodesContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> EpisodesContentConfiguration {
        self
    }

}

final class EpisodesContentView: UIView, UIContentView {

    private var contentConfiguration: EpisodesContentConfiguration

    var configuration: UIContentConfiguration {
        get { contentConfiguration }
        set {
            guard let newConfiguration = newValue as? EpisodesContentConfiguration else { return }
            contentConfiguration = newConfiguration
            update(with: contentConfiguration.model)
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()

    init(configuration: EpisodesContentConfiguration) {
        self.contentConfiguration = configuration
        super.init(frame: .zero)
        layer.cornerRadius = 16
        backgroundColor = .gray
        addSubviews()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension EpisodesContentView {

    func update(with model: EpisodeModel) {
        titleLabel.text = model.name
    }

    func addSubviews() {
        addSubview(titleLabel)
    }

    func addConstraints() {

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32)
        ])
    }
}
