//
//  PokemonViewModel.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 2/2/24.
//

import SwiftUI

class PokemonViewModel: ObservableObject {
    private let pokemonManager: PokemonManagerProtocol
    
    @Published var pokemonList = [Pokemon]()
    @Published var pokemonDetails: DetailPokemon?
    @Published var searchText = ""
    @Published var favoritePokemonsList = [Pokemon]()
    @Published var favoritePokemonsDetailsList = [DetailPokemon]()
    
    init(pokemonManager: PokemonManagerProtocol) {
        CacheManager.shared.removeCache()
        self.pokemonManager = pokemonManager
        
        pokemonManager.getPokemons () { data in
            DispatchQueue.main.async {
                self.pokemonList = data
            }
        }
        self.favoritePokemonsList = CacheManager.shared.getPokemons() ?? []
        self.favoritePokemonsDetailsList = CacheManager.shared.getPokemonDetails() ?? []
    }
    
    var filteredPokemon: [Pokemon] {
        return searchText == "" ? pokemonList : pokemonList.filter { $0.name.contains(searchText.lowercased()) }
    }
    
    var favoritesPokemons: [Pokemon] {
        return favoritePokemonsList
    }
    
    var favoriteButtonText: String {
        return pokemonDetails?.favorite ?? false ? AppConstants.deleteFavoriteText : AppConstants.makeFavoriteText
    }
    
    var isFavoritePokemon: Bool {
        return pokemonDetails?.favorite ?? false
    }
    
    var lastLoadedPokemonIndex: Int {
        return pokemonList.count - 1
    }
    
    func getPokemonList(){
        pokemonManager.getPokemons () { data in
            DispatchQueue.main.async {
                self.pokemonList = data
            }
        }
    }
    
    func getDetails(pokemon: Pokemon) {
        pokemonDetails = nil
        
        if checkPokemonIsFavorite(pokemon: pokemon) {
            if let data = favoritePokemonsDetailsList.first(where: { $0.id == pokemon.id }) {
                self.pokemonDetails = data
            }
        } else {
            self.pokemonDetails = DetailPokemon(id: 0, height: 0, weight: 0, favorite: checkPokemonIsFavorite(pokemon: pokemon))
            
            pokemonManager.getDetailedPokemon(pokemon: pokemon) { data in
                DispatchQueue.main.async {
                    self.pokemonDetails = data
                }
            }
        }
        
    }
    
    func loadMorePokemon() {
        pokemonManager.getMorePokemons() { data in
            DispatchQueue.main.async {
                self.pokemonList += data
            }
        }
    }
    
    func getFavoritePokemons() {
        self.favoritePokemonsList = CacheManager.shared.getPokemons() ?? []
        self.favoritePokemonsDetailsList = CacheManager.shared.getPokemonDetails() ?? []
    }
    
    func makePokemonFavorite(pokemon: Pokemon){
        if !favoritePokemonsList.contains(where: { $0.id == pokemon.id }) {
            favoritePokemonsList.append(pokemon)
            pokemonDetails?.favorite = true
            saveToCache(pokemon: favoritePokemonsList)
        }
        
        if !favoritePokemonsDetailsList.contains(where: { $0.id == pokemon.id }) {
            if let pokemonDetail = pokemonDetails {
                favoritePokemonsDetailsList.append(pokemonDetail)
                pokemonDetails?.favorite = true
                saveToCacheDetail(pokemon: favoritePokemonsDetailsList)
            }
        }
    }
    
    func deletePokemonFavorite(pokemon: Pokemon){
        if favoritePokemonsList.contains(where: { $0.id == pokemon.id }) {
            favoritePokemonsList.removeAll { $0.id == pokemon.id }
            pokemonDetails?.favorite = false
            saveToCache(pokemon: favoritePokemonsList)
        }
        
        if favoritePokemonsDetailsList.contains(where: { $0.id == pokemon.id }) {
            favoritePokemonsDetailsList.removeAll { $0.id == pokemon.id }
            pokemonDetails?.favorite = false
            saveToCacheDetail(pokemon: favoritePokemonsDetailsList)
        }
    }
    
    private func saveToCache(pokemon: [Pokemon]) {
        CacheManager.shared.savePokemon(pokemon)
    }
    
    private func saveToCacheDetail(pokemon: [DetailPokemon]) {
        CacheManager.shared.savePokemonDetails(pokemon)
    }
    
    func formatHW(value: Int) -> String {
        let dValue = Double(value)
        let string = String(format: "%.2f", dValue / 10)
        return string
    }
    
    private func checkPokemonIsFavorite(pokemon: Pokemon) -> Bool {
        if favoritePokemonsList.contains(where: { $0.id == pokemon.id }) {
            return true
        } else {
            return false
        }
    }
    
}
