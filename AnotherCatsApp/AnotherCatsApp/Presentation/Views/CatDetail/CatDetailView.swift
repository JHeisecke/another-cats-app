//
//  CatDetailView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import SwiftUI

struct CatDetailView: View {

    @Environment(\.dismiss) private var dismiss

    let cat: CatModel

    var body: some View {
        ScrollView {
            VStack {
                HeroCellView(
                    title: cat.breeds,
                    subtitle: cat.personality,
                    imageName: cat.imageUrl
                )
                .frame(maxWidth: .infinity)
                .frame(height: 500)
                infoView
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .ignoresSafeArea()
        .background(Color.accent.opacity(0.1))
        .overlay(alignment: .topTrailing) {
            closeButton
        }
    }

    private var closeButton: some View {
        Image(systemName: "xmark")
            .foregroundStyle(.accent)
            .bold()
            .padding(10)
            .background(.white, in: .circle)
            .contentShape(.circle)
            .shadow(radius: 1)
            .anyButton(.press) {
                onDismissPressed()
            }
            .padding()
            .accessibilityIdentifier(AccessibilityIdentifiers.closeDetailButton)
    }

    // MARK: - Info

    private var infoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(cat.description)
                .font(.body)
                .padding(.horizontal)

            infoRow(label: "Origin", value: cat.origin)
            infoRow(label: "Life Span", value: "\(cat.lifeSpan) years")

            ratingRow(label: "Energy Level", rating: cat.energyLevel)
            ratingRow(label: "Affection Level", rating: cat.affectionLevel)
            ratingRow(label: "Shedding Level", rating: cat.sheddingLevel)
        }
        .padding()
        .padding(.bottom)
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.body)
        }
        .padding(.horizontal)
    }

    private func ratingRow(label: String, rating: Int) -> some View {
        HStack {
            Text(label)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
            HStack(spacing: 5) {
                ForEach(0..<5) { index in
                    Image(systemName: index < rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Actions

    func onDismissPressed() {
        dismiss()
    }

}

// MARK: - Preview

#Preview {
    CatDetailView(cat: CatModel.mock)
}
