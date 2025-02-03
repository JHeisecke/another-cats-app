//
//  InteractionsView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct InteractionsView: View {

    var interactionPressed: () -> Void

    var body: some View {
        HStack {
            likeButton
            Spacer()
            dislikeButton
        }
        .padding()
    }

    var likeButton: some View {
        Image(systemName: "heart.fill")
            .font(.title)
            .bold()
            .foregroundStyle(.white)
            .padding(.vertical, 30)
            .padding(.horizontal, 60)
            .background {
                Color.accent
                    .clipShape(.capsule)
            }
            .anyButton(.press) {
                interactionPressed()
            }

    }

    var dislikeButton: some View {
        Image(systemName: "xmark")
            .font(.title)
            .bold()
            .foregroundStyle(.white)
            .padding(.vertical, 30)
            .padding(.horizontal, 60)
            .background {
                Color.accent
                    .clipShape(.capsule)
            }
            .anyButton(.press) {
                interactionPressed()
            }
    }
}

#Preview {
    InteractionsView(interactionPressed: { })
    .background(.accent.opacity(0.2))
}
