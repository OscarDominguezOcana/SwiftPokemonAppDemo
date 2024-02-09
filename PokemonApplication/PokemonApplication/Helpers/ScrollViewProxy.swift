//
//  ScrollViewProxy.swift
//  PokemonApplication
//
//  Created by Oscar Dominguez Ocaña on 9/2/24.
//

import SwiftUI

struct ScrollViewProxy: UIViewRepresentable {
    var onScroll: (CGPoint) -> Void

    func makeUIView(context: Context) -> some UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        return scrollView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(onScroll: onScroll)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var onScroll: (CGPoint) -> Void

        init(onScroll: @escaping (CGPoint) -> Void) {
            self.onScroll = onScroll
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let contentOffset = scrollView.contentOffset
            onScroll(contentOffset)
        }
    }
}
