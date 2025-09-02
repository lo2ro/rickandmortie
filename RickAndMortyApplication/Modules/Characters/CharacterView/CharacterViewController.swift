//
//  CharacterViewController.swift
//  RickAndMortyApplication
//
//  Created by Toshpulatova Lola on 30.08.2025.
//
import UIKit

final class CharacterViewController: UIViewController {

    lazy var contentView: DisplaysCharacter = CharacterView()
    private var characters: [CharacterModel] = []

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView as? UIView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.02, green: 0.05, blue: 0.12, alpha: 1.0)
        fetchCharacters()
    }

    private func fetchCharacters() {
        NetworkService.shared.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characters = characters.map { CharacterModel(from: $0) }
                    self?.contentView.setupCharacters(self?.characters ?? [])
                case .failure(let error):
                    print("Error fetching characters: \(error.localizedDescription)")
                    // Можно показать alert или использовать моковые данные
                    self?.showMockData()
                }
            }
        }
    }

    private func showMockData() {
        // Резервные данные если API не работает
        characters = [
            CharacterModel(id: 1, name: "Rick Sanchez", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"),
            CharacterModel(id: 2, name: "Morty Smith", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"),
            CharacterModel(id: 3, name: "Summer Smith", image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg")
        ]
        contentView.setupCharacters(characters)
    }
}

// MARK: - DisplaysCharacter Protocol

extension CharacterViewController: DisplaysCharacter {
    func setupCharacters(_ model: [CharacterModel]) {
        // Эта функция теперь вызывается из NetworkService
        print("Characters loaded: \(model.count)")
    }
}
