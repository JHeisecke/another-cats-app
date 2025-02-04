//
//  AppView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct AppView: View {

    let catFeedViewModel: CatsFeedViewModel

    var body: some View {
        CatsFeedView(
            viewModel: catFeedViewModel
        )
        .preferredColorScheme(.light)
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
