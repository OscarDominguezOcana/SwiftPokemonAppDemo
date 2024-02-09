//
//  MockPokemonManager.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 8/2/24.
//

import Foundation

class MockPokemonManager: PokemonManagerProtocol {
    
    func getDetailedPokemon(pokemon: Pokemon, completion: @escaping (DetailPokemon) -> Void) {
        
    }
    
    func getMorePokemons(completion: @escaping ([Pokemon]) -> ()) {
        
    }
    
    
    func getPokemons(completion: @escaping ([Pokemon]) -> Void) {
        if let url = Bundle.main.url(forResource: "pokemon", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let pokemonPage = try? JSONDecoder().decode(PokemonPage.self, from: data) {
            completion(pokemonPage.results)
        } else {
            completion([])
        }
    }
}
