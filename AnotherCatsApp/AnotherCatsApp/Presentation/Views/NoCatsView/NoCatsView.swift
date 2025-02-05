//
//  NoCatsView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct NoCatsView: View {

    var reload: () async -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cat")
                .font(.largeTitle)
            Text("The cats can't come out right now.\n Hit the reload button.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "arrow.clockwise")
                .font(.largeTitle)
                .foregroundStyle(.accent)
                .padding()
                .anyButton {
                    onRefreshPressed()
                }
        }
    }

    // MARK: - Actions

    func onRefreshPressed() {
        Task {
            await reload()
        }
    }
}

// MARK: - Preview

#Preview {
    NoCatsView { }
}
