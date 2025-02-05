//
//  AnotherCatsAppApp.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

@main
struct AnotherCatsAppApp: App {

    var body: some Scene {
        WindowGroup {
            Group {
                if Utilities.isUITesting {
                    AppView(
                        catFeedViewModel: CatsFeedViewModel(
                            repository: CatsRepository(
                                apiClient: MockAPIClient()
                            ),
                            isUITesting: true
                        )
                    )
                } else {
                    AppView(
                        catFeedViewModel: CatsFeedViewModel(
                            repository: CatsRepository(
                                apiClient: APIClient()
                            )
                        )
                    )
                }
            }
        }
    }
}
