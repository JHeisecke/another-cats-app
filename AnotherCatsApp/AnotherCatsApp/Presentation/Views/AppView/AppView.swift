//
//  AppView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct AppView: View {

    let catFeedViewModel: CatsFeedViewModel
    @State private var orientation = UIDeviceOrientation.unknown

    var body: some View {
        CatsFeedView(
            viewModel: catFeedViewModel
        )
        .preferredColorScheme(.light)
        .onRotate { newOrientation in
            orientation = newOrientation
        }
        .environment(\.deviceOrientation, orientation)
    }
}

#Preview {
    AppView(
        catFeedViewModel: CatsFeedViewModel(
            repository: CatsRepository(
                apiClient: MockAPIClient()
            )
        )
    )
}
