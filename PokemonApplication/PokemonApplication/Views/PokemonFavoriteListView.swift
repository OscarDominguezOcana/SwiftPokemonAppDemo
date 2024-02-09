//
//  PokemonFavoriteListView.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 2/2/24.
//

import SwiftUI

struct PokemonFavoriteListView: View {
    
    @StateObject var vm = PokemonViewModel(pokemonManager: PokemonManager())
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 30) {
                    ForEach(vm.favoritesPokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)
                        ) {
                            PokemonView(pokemon: pokemon)
                        }
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: vm.favoritesPokemons.count)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing:
                                        HStack {
                    Spacer()
                    Image ("PokemonLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                    .padding(5)
                )
            }.onAppear {
                vm.getFavoritePokemons()
            }
        }
        .environmentObject(vm)
    }
}

struct PokemonFavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonFavoriteListView()
    }
}
