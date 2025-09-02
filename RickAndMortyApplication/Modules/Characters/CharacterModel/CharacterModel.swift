//
//  CharacterModel.swift
//  RickAndMortyApplication
//
//  Created by Toshpulatova Lola on 25.08.2025.
//

struct CharacterModel: Hashable {
    let id: Int
    let name: String
    let image: String
    let status: String?
    let species: String?

    // Для конвертации из API модели
    init(from character: Character) {
        self.id = character.id
        self.name = character.name
        self.image = character.image
        self.status = character.status
        self.species = character.species
    }

    // Для моковых данных
    init(id: Int, name: String, image: String, status: String? = nil, species: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
    }
}
