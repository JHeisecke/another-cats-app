//
//  NoCatsView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct NoCatsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cat")
                .font(.largeTitle)
            Text("The cats can't come out right now.\n Try again later!")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .font(.title)
        }

    }
}

#Preview {
    NoCatsView()
}
