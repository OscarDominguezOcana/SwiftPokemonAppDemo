//
//  SplashScreenView.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 3/2/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.6
    @State private var opacity = 0.2
    
    var body: some View {
        
        if isActive {
            TabBarView()
        } else {
            VStack {
                Spacer()
                VStack {
                    Image ("PokemonLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
            .background(AppConstants.mainColor)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
