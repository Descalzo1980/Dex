//
//  FetchServise.swift
//  Dex
//
//  Created by Станислав Леонов on 28.08.2025.
//

import Foundation

struct FetchServise {
    enum FetchError: Error {
        case badResponse
    }
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func fetchPokemon(_ id: Int) async throws -> FetchedPokemon {
        let fetchURL = baseUrl.appending(path: String(id))
        let(data, response) = try await URLSession.shared.data(from: fetchURL)
        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            throw FetchError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let pokemon = try decoder.decode(FetchedPokemon.self, from: data)
        
        print("Fetched pokemon: \(pokemon.id): \(pokemon.name.capitalized)")
        
        return pokemon
    }
}
