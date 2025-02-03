//
//  MainView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct MainView: View {

    @State private var scrollPosition: Int?

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<20) { index in
                        HeroCellView(title: "cat number \(index)")
                            .frame(maxWidth: .infinity)
                            .containerRelativeFrame(.vertical, alignment: .center)
                            .id(index)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $scrollPosition, anchor: .center)
            .animation(.smooth, value: scrollPosition)
            InteractionsView {
                scrollPosition = (0..<20).randomElement() ?? 0
            }
        }
        .background(Color.accent.opacity(0.4))
    }
}

#Preview {
    MainView()
}
