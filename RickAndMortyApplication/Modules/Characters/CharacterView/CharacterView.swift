//
//  CharacterView.swift
//  RickAndMortyApplication
//
//  Created by Toshpulatova Lola on 25.08.2025.
//
import UIKit

protocol DisplaysCharacter: AnyObject {
    func setupCharacters(_ model: [CharacterModel])
}

final class CharacterView: UIView {

    typealias DataSource = UICollectionViewDiffableDataSource<CharacterSectionType, CharacterItemType>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, CharacterItemType>
    typealias Snapshot = NSDiffableDataSourceSnapshot<CharacterSectionType, CharacterItemType>


    private let collectionView: UICollectionView = {
        let characterCollectionLayout = CharacterCollectionLayout()
        let layout = characterCollectionLayout.createCharacterLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addSubviews()
        addConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var dataSource = setUpDataSource()

}

extension CharacterView: DisplaysCharacter {
    func setupCharacters(_ model: [CharacterModel]) {
        setupSnapshot(with: model)
    }
}

private extension CharacterView {
    func setUpDataSource() -> DataSource {
        let cellRegistration = createCellRegistration()
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item)
        }
        return dataSource
    }
    func createCellRegistration() -> CellRegistration {
        CellRegistration { [weak self] cell, _, item in
            guard let self = self else { return }
            switch item {
            case .character(let model):
                cell.contentConfiguration = setupCharactersContentConfiguration(for: model)
            }
        }
    }

    func setupSnapshot(with model: [CharacterModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.character])
        let items = model.map { model in
            CharacterItemType.character(model)
        }
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }

    func setupCharactersContentConfiguration(for model: CharacterModel) -> CharacterContentConfiguration {
        let model = CharacterModel(
            id: model.id,
            name: model.name,
            image: model.image
        )
        return CharacterContentConfiguration(model: model)
    }

    func addSubviews() {
        addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1.0) // Тёмно-синий как в Figma


        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
