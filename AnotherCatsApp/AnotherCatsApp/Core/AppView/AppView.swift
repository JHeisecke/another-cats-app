//
//  AppView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct AppView: View {

    @State private var hasData: Bool = true

    var body: some View {
        if hasData {
            MainView()
        } else {
            NoCatsView()
        }
    }
}

#Preview {
    AppView()
}
