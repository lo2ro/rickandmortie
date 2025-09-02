//
//  NetworkService.swift
//  RickAndMortyApplication
//
//  Created by Toshpulatova Lola on 31.08.2025.
//

import Foundation

// Модели для API
struct CharactersResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}

// Сетевой сервис
final class NetworkService {
    static let shared = NetworkService()
    private init() {}

    private let baseURL = "https://rickandmortyapi.com/api"

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let response = try JSONDecoder().decode(CharactersResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchCharacter(by id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/character/\(id)") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                completion(.success(character))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
