//
//  CharacterCollectionLayout.swift
//  RickAndMortyApplication
//
//  Created by Toshpulatova Lola on 25.08.2025.
//
import UIKit

struct CharacterCollectionLayout {
    func createCharacterLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection in
            self.createSection()}
    }
}


private extension CharacterCollectionLayout {
    func createSection() -> NSCollectionLayoutSection {
        // 1. Размер item (ячейки) - 2 в ряду с отступами
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.48),  // 48% ширины для отступов
            heightDimension: .estimated(200)         // Автоматическая высота
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // 2. Размер group (группа из 2 ячеек)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),   // 100% ширины секции
            heightDimension: .estimated(200)         // Автоматическая высота
        )

        // 3. Группа из 2 items в ряд
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(16)  // Расстояние между ячейками в группе

        // 4. Создаем секцию
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16       // Расстояние между рядами
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 16,
            bottom: 20,
            trailing: 16
        )

        return section
    }
}
