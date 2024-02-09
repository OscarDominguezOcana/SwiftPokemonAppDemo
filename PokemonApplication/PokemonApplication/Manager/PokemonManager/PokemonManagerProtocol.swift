//
//  PokemonManagerProtocol.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 8/2/24.
//

import Foundation

protocol PokemonManagerProtocol {
    func getPokemons(completion: @escaping ([Pokemon]) -> Void)
    func getMorePokemons(completion: @escaping ([Pokemon]) -> ())
    func getDetailedPokemon(pokemon: Pokemon, completion: @escaping (DetailPokemon) -> Void)
}
