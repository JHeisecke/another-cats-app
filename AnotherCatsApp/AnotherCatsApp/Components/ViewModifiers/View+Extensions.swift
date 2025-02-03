//
//  View+Extensions.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

extension View {
    func addingGradientBackgroundForText() -> some View {
        self
            .background(
                LinearGradient(colors: [
                    .black.opacity(0),
                    .black.opacity(0.3),
                    .black.opacity(0.4)
                ], startPoint: .top, endPoint: .bottom)
            )
    }
}
