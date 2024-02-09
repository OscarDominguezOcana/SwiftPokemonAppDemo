//
//  PokemonDetailView.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 1/2/24.
//

import SwiftUI
import CachedAsyncImage

struct PokemonDetailView: View {
    
    @EnvironmentObject var vm: PokemonViewModel
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack (alignment: .leading) {
            
            CachedAsyncImage(url: URL(string: "\(AppConstants.imageBaseUrl)\(pokemon.id).png")) { image in
                if let image = Optional(image) {
                    image
                        .resizable()
                        .scaledToFit()
                }
            } placeholder: {
                ProgressView()
            }
            .background(AppConstants.mainColor)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(pokemon.name.capitalized)")
                    .font(.system(size: 24, weight: .regular, design: .monospaced))
                Text("**ID**: \(vm.pokemonDetails?.id ?? 0)")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                Text("**Peso**: \(vm.formatHW(value: vm.pokemonDetails?.weight ?? 0)) KG")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                Text("**Altura**: \(vm.formatHW(value: vm.pokemonDetails?.height ?? 0)) M")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    if vm.isFavoritePokemon {
                        vm.deletePokemonFavorite(pokemon: pokemon)
                    } else {
                        vm.makePokemonFavorite(pokemon: pokemon)
                    }
                }
            }) {
                Text(vm.favoriteButtonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .font(.system(size: 22, weight: .regular, design: .monospaced))
                    .background(AppConstants.mainColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(.thinMaterial)
        .onAppear {
            vm.getDetails(pokemon: pokemon)
        }
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(pokemon: Pokemon.samplePokemon)
            .environmentObject(PokemonViewModel(pokemonManager: PokemonManager()))
    }
}

