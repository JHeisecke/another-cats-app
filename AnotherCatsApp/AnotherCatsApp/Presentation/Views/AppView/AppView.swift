//
//  AppView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct AppView: View {

    var body: some View {
        CatsFeedView(
            viewModel: CatsFeedViewModel(
                repository: CatsRepository(
                    apiClient: APIClient()
                )
            )
        )
        .preferredColorScheme(.light)
    }
}

#Preview {
    AppView()
}
