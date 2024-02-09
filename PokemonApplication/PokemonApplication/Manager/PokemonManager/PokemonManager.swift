//
//  PokemonManager.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 2/2/24.
//

import Foundation

class PokemonManager: PokemonManagerProtocol {
    
    var nextPagedMokemon: String = ""
    var morePokemonsCalls = 0
    
    func getPokemons(completion: @escaping ([Pokemon]) -> ()){
        Bundle.main.fetchData(url: AppConstants.pokemonAPIBaseURL, model: PokemonPage.self) { data in
            self.nextPagedMokemon = data.next
            completion(data.results)
            print(data)
            
        } failure: { error in
            print(error)
        }
    }
    
    func getMorePokemons(completion: @escaping ([Pokemon]) -> ()){
        if self.nextPagedMokemon != "" && self.morePokemonsCalls <= 5 {
            morePokemonsCalls+=1
            Bundle.main.fetchData(url: self.nextPagedMokemon, model: PokemonPage.self) { data in
                self.nextPagedMokemon = data.next
                completion(data.results)
                print(data)
                
            } failure: { error in
                print(error)
            }
        }
    }
    
    func getDetailedPokemon(pokemon: Pokemon, completion: @escaping (DetailPokemon) -> ()) {
        Bundle.main.fetchData(url: "\(AppConstants.pokemonAPIBaseURL)\(pokemon.id)/", model: DetailPokemonCodable.self) { data in
            let myCustomPokemon = self.mapDetailPokemonToCustom(data, pokemon: pokemon)
            completion(myCustomPokemon)
            print(myCustomPokemon)
        } failure: { error in
            print(error)
        }
    }
    
    private func mapDetailPokemonToCustom(_ detailPokemon: DetailPokemonCodable, pokemon: Pokemon) -> DetailPokemon {
        let customPokemon = DetailPokemon(id: detailPokemon.id, height: detailPokemon.height, weight: detailPokemon.weight, name: pokemon.name)
        return customPokemon
    }
}

