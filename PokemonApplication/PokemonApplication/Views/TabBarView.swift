//
//  TabBarView.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 2/2/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            
            PokemonListView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text(AppConstants.tabBarTitle1)
                }
            
            PokemonFavoriteListView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text(AppConstants.tabBarTitle2)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
