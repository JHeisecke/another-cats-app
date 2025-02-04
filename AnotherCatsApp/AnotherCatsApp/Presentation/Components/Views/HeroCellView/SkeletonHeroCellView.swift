//
//  HeroCellViewBuilder.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct SkeletonHeroCellView: View {

    var body: some View {
        HeroCellView(
            title: "xxxx xxxx xxxx xxxxx",
            subtitle: "xxxx, xxxxx, xxxxx, xxxxx, xxxxx, xxxx,"
        )
        .redacted(reason: .placeholder)
    }

}
