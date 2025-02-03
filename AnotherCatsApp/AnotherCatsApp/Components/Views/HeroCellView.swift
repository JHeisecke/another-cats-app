//
//  HeroCellView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct HeroCellView: View {

    var title: String? = "This is some title"
    var subtitle: String? = "This is some subtitle"
    var imageName: String? = Constants.randomImage

    var body: some View {
        ZStack {
            if let imageName {
                ImageLoaderView(urlString: imageName)
            } else {
                Rectangle()
                    .fill(.accent)
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
            HeroCellView(imageName: nil)
                .frame(width: 300, height: 200)
            HeroCellView(title: nil)
                .frame(width: 300, height: 200)
            HeroCellView(subtitle: nil)
                .frame(width: 300, height: 200)
            HeroCellView()
                .frame(width: 300, height: 400)
            HeroCellView()
                .frame(width: 100, height: 200)
        }
        .frame(maxWidth: .infinity)
    }
}
