//
//  AnotherCatsAppApp.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

@main
struct AnotherCatsAppApp: App {

    var apiClient: APIClientProtocol {
        Utilities.isUITesting ? MockAPIClient(hasError: Utilities.hasError, isEmpty: Utilities.isEmptyFeed) : APIClient()
    }

    var body: some Scene {
        WindowGroup {
            AppView(
                catFeedViewModel: CatsFeedViewModel(
                    repository: CatsRepository(
                        apiClient: apiClient
                    )
                )
            )
        }
    }
}
