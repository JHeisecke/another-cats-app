//
//  View+CustomAlert.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

extension View {

    func showCustomAlert(alert: Binding<CustomAlert?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                alert.wrappedValue?.buttons()
            } message: {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            }
    }

}
