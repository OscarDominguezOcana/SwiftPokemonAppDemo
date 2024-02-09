//
//  PokemonView.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 1/2/24.
//

import SwiftUI
import CachedAsyncImage

struct PokemonView: View {
    @EnvironmentObject var vm: PokemonViewModel
    let pokemon: Pokemon
    let dimensions: Double = 140
    
    var body: some View {
        VStack {
            CachedAsyncImage(url: URL(string: "\(AppConstants.imageBaseUrl)\(pokemon.id).png")) { image in
                if let image = Optional(image) {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: dimensions, height: dimensions)
                }
            } placeholder: {
                ProgressView()
                    .frame(width: dimensions, height: dimensions)
            }
            .background(.thinMaterial)
            .clipShape(Circle())

            Text("\(pokemon.name.capitalized)")
                .font(.system(size: 16, weight: .regular, design: .monospaced))
                .padding(.bottom, 20)
        }
    }
}

struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemon: Pokemon.samplePokemon)
            .environmentObject(PokemonViewModel(pokemonManager: PokemonManager()))
    }
}
