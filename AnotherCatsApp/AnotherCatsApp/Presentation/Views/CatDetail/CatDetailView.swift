//
//  CatDetailView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-04.
//

import SwiftUI

struct CatDetailView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var scaleFactor: CGFloat = 1
    @State private var cornerRadius: CGFloat = 16
    @State private var opacity: CGFloat = 1

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
            .scaleEffect(scaleFactor)
        }
        .scrollIndicators(.hidden)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .ignoresSafeArea()
        .background(Color.accent.opacity(0.1))
        .onScrollGeometryChange(for: CGFloat.self, of: { geometry in
            geometry.contentOffset.y
        }, action: { _, newValue in
            if newValue >= 0 {
                scaleFactor = 1
                cornerRadius = 16
                opacity = 1
            } else {
                scaleFactor = 1 - (0.1 * (newValue / -50))
                cornerRadius = 55 - (35 / 50 * -newValue)
                opacity = 1 - (abs(newValue) / 50)
            }
        })
        .onScrollGeometryChange(for: Bool.self, of: { geometry in
            geometry.contentOffset.y < -50
        }, action: { _, isTornOff in
            if isTornOff {
                dismiss()
            }
        })
        .overlay(alignment: .topTrailing) {
            closeButton
        }
        .opacity(opacity)
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

#Preview {
    CatDetailView(cat: CatModel.mock)
}
