//
//  InteractionsView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct InteractionsView: View {

    @Environment(\.deviceOrientation) private var orientation
    var interactionPressed: () -> Void

    var body: some View {
        if orientation.isLandscape {
            interactionsStack
                .padding(.horizontal)
        } else {
            interactionsStack
                .padding()
                .padding(.bottom)
        }
    }

    private var interactionsStack: some View {
        HStack {
            likeButton
            Spacer()
            dislikeButton
        }
    }

    private var likeButton: some View {
        Image(systemName: "heart.fill")
            .font(.title)
            .bold()
            .foregroundStyle(.white)
            .padding(.vertical, 30)
            .padding(.horizontal, 60)
            .background(
                LinearGradient(
                    colors: [
                        Color.accent,
                        Color.accent.opacity(0.8)
                    ],
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
                .clipShape(Capsule())
            )
            .shadow(color: Color.gray.opacity(0.4), radius: 8, x: 0, y: 5)
            .anyButton(.press) {
                interactionPressed()
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }
            .accessibilityIdentifier(AccessibilityIdentifiers.likeButton)
    }

    private var dislikeButton: some View {
        Image(systemName: "xmark")
            .font(.title)
            .bold()
            .foregroundStyle(.accent)
            .padding(.vertical, 30)
            .padding(.horizontal, 60)
            .background {
                Color.white
                    .clipShape(.capsule)
            }
            .shadow(color: Color.accent.opacity(0.4), radius: 8, x: 0, y: 5)
            .anyButton(.press) {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                interactionPressed()
            }
            .accessibilityIdentifier(AccessibilityIdentifiers.dislikeButton)
    }
}

#Preview {
    InteractionsView(interactionPressed: { })
        .background(.accent.opacity(0.2))
}
