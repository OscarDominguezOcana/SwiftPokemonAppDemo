//
//  CacheManager.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 4/2/24.
//

import Foundation

class CacheManager {
    
    static let shared = CacheManager()
    private let key = "pokemonList"
    private let key2 = "pokemonDetails"
    
    func removeCache() {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.removeObject(forKey: key2)
    }


    func savePokemon(_ object: [Pokemon]) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Error encoding object: \(error)")
        }
    }

    func getPokemons() -> [Pokemon]? {
        if let data = UserDefaults.standard.data(forKey: key) {
            do {
                let object = try JSONDecoder().decode([Pokemon].self, from: data)
                return object
            } catch {
                print("Error decoding object: \(error)")
                return nil
            }
        }
        return nil
    }
    
    func savePokemonDetails(_ object: [DetailPokemon]) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key2)
        } catch {
            print("Error encoding object: \(error)")
        }
    }
    
    func getPokemonDetails() -> [DetailPokemon]?  {
        if let data = UserDefaults.standard.data(forKey: key2) {
            do {
                let object = try JSONDecoder().decode([DetailPokemon].self, from: data)
                return object
            } catch {
                print("Error decoding object: \(error)")
                return nil
            }
        }
        return nil
    }
}
