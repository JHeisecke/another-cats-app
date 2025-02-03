//
//  MainView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<20) { index in
                        ImageLoaderView(urlString: Constants.randomImage)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(.white)
                            }
                            .containerRelativeFrame(.vertical, alignment: .center)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    MainView()
}
