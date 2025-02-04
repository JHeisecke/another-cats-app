//
//  MainView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct CatsFeedView: View {

    @State var viewModel: CatsFeedViewModel

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .firstLoad:
                SkeletonHeroCellView()
            case .data:
                scrollableCats()
                    .background(Color.accent.opacity(0.4))
            case .empty:
                NoCatsView()
                    .background(Color.accent.opacity(0.4))
            }
        }
        .ignoresSafeArea()
        .showCustomAlert(alert: $viewModel.showAlert)
        .task {
            await viewModel.getCatsFeed()
        }
    }

    private func scrollableCats() -> some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.cats.indices, id: \.self) { index in
                        let cat = viewModel.cats[index]
                        HeroCellView(title: cat.breeds, subtitle: cat.personality, imageName: cat.imageUrl)
                            .frame(maxWidth: .infinity)
                            .containerRelativeFrame(.vertical, alignment: .center)
                            .id(index)
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $viewModel.scrollPosition, anchor: .center)
            .animation(.default, value: viewModel.scrollPosition)
            InteractionsView {
                viewModel.interactWithCat()
            }
            .padding(.bottom)
        }
    }
}

#Preview {
    CatsFeedView(viewModel: CatsFeedViewModel(repository: MockCatsRepository()))
}
