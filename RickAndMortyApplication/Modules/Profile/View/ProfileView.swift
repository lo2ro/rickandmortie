//
//  ProfileView.swift
//  RickAndMortyApplication
//
//  Created by Mitina Ekaterina on 19.08.2025.
//
import UIKit

protocol DisplaysProfile: UIView {
    func setupEpisodes(_ model: [EpisodeModel])
}

final class ProfileView: UIView {

    typealias Snapshot = NSDiffableDataSourceSnapshot<ProfileSectionType, ProfileItem>
    typealias DataSource = UICollectionViewDiffableDataSource<ProfileSectionType, ProfileItem>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ProfileItem>

    private lazy var dataSource = setupDataSource()

    private let collectionView: UICollectionView = {
        let episodesCollectionLayout = EpisodesCollectionLayout()
        let layout = episodesCollectionLayout.createEpisodesLayout() // главная функция где создаем секцию
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1.0)
        collectionView.contentInset.bottom = 86 // высота последней ячейки на экране
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
    
}

extension ProfileView: DisplaysProfile {
    func setupEpisodes(_ model: [EpisodeModel]) {
        setupSnapshot(with: model)
    }

}

private extension ProfileView {

    func addSubviews() {
        addSubview(collectionView)
    }

    func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupDataSource() -> DataSource {
        let cellRegistration = createCellRegistration()
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }
        return dataSource
    }

    func setupSnapshot(with model: [EpisodeModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.episodes])
        let items = model.map { model in
            ProfileItem.episodes(model)
        }
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }

    func createCellRegistration() -> CellRegistration {
        CellRegistration { [weak self] cell, _, item in
            guard let self = self else { return }
            switch item {
            case .episodes(let model):
                cell.contentConfiguration = setupEpisodesContentConfiguration(for: model)
            }
        }
    }

    func setupEpisodesContentConfiguration(for item: EpisodeModel) -> EpisodesContentConfiguration {
        let model = EpisodeModel(
            name: item.name,
            episodeNumber: item.episodeNumber,
            date: item.date
        )
        return EpisodesContentConfiguration(model: model)
    }

}
