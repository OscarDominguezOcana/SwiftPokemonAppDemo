//
//  ContentView.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 1/2/24.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var vm = PokemonViewModel(pokemonManager: PokemonManager())
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if vm.filteredPokemon.isEmpty {
                    VStack {
                        ErrorView()
                    }
                } else {
                    LazyVGrid(columns: adaptiveColumns, spacing: 30) {
                        ForEach(vm.filteredPokemon) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                PokemonView(pokemon: pokemon)
                            }.onAppear {
                                if vm.filteredPokemon.last == pokemon {
                                    vm.loadMorePokemon()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: 0.3), value: vm.filteredPokemon.count)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    HStack {
                Spacer()
                Image("PokemonLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
                .padding(5)
            )
            .onAppear {
                vm.getFavoritePokemons()
            }
            .searchable(text: $vm.searchText, prompt: AppConstants.searchPokemonText)
        }
        .environmentObject(vm)
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}

struct ErrorView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .foregroundColor(.red)
                .font(.system(size: 50))
            
            Text(AppConstants.resultsNotFound)
                .font(.system(size: 20))
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
