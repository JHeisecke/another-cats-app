//
//  HeroCellView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct HeroCellView: View {

    var title: String?
    var subtitle: String?
    var imageName: String?

    var body: some View {
        ZStack {
            if let imageName, !imageName.isEmpty {
                ImageLoaderView(urlString: imageName)
            } else {
                Rectangle()
                    .fill(.accent.opacity(0.4))
                    .overlay {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 4) {
                if let title {
                    Text(title)
                        .font(.headline)
                }
                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
            .foregroundStyle(.white)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .addingGradientBackgroundForText()
        }
    }
}

#Preview {
    ScrollView {
        VStack {
            HeroCellView(title: "This is some Title", subtitle: "This is some subtitle", imageName: nil)
                .frame(width: 300, height: 200)
            HeroCellView(title: "A Title", subtitle: "a subtitle", imageName: "https://picsum.photos/600/600")
                .frame(width: 300, height: 200)
            HeroCellView(title: "This is some Title", subtitle: nil, imageName: nil)
                .frame(width: 300, height: 200)
            HeroCellView(title: nil, subtitle: "This is some subtitle", imageName: "https://picsum.photos/600/600")
                .frame(width: 300, height: 400)
            HeroCellView()
                .frame(width: 100, height: 200)
        }
        .frame(maxWidth: .infinity)
    }
}
