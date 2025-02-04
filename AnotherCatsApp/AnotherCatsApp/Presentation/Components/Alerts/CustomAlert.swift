//
//  CustomAlert.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI
import Foundation

struct CustomAlert: Sendable {
    var title: String
    var subtitle: String?
    var buttons: @Sendable () -> AnyView

    init(
        title: String,
        subtitle: String? = nil,
        buttons: (@Sendable () -> AnyView)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK", action: {

                })
            )
        }
    }

    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
}
