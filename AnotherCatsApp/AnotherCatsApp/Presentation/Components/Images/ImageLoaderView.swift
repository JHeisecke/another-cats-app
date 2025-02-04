//
//  ImageLoaderView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {

    var urlString: String
    var resizingMode = ContentMode.fill
    var forceTransitionAnimation = false

    var body: some View {
        Rectangle()
            .opacity(0.0001)
            .overlay {
                WebImage(url: URL(string: urlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: resizingMode)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoaderView(urlString: "https://picsum.photos/600/600")
        .frame(width: 100, height: 200)
}
