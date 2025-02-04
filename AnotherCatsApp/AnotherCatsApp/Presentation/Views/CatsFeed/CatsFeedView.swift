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
                    .ignoresSafeArea()
                    .background(Color.accent.opacity(0.4))
            case .empty:
                NoCatsView(reload: viewModel.getCatsFeed)
            }
        }
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
                            .id(cat.id)
                            .anyButton {

                            }
                    }
                }
            }
            .ignoresSafeArea()
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
            .scrollPosition(id: $viewModel.scrollPosition, anchor: .center)
            .animation(.default, value: viewModel.scrollPosition)
            .onChange(of: viewModel.scrollPosition) { _, scrollPosition in
                if let scrollPosition = viewModel.scrollPosition {
                    viewModel.fetchMoreCatsIfNecessary(currentCatId: scrollPosition)
                }
            }
            InteractionsView {
                if let scrollPosition = viewModel.scrollPosition {
                    viewModel.interactWithCat(currentCatId: scrollPosition)
                }
            }
            .padding(.bottom)
        }
    }
}

#Preview("Empty State") {
    CatsFeedView(viewModel: CatsFeedViewModel(repository: MockCatsRepository()))
}

#Preview("Feed with Images") {
    let repository = MockCatsRepository()
    repository.result = .success(CatsListResponse.mocks)
    return CatsFeedView(viewModel: CatsFeedViewModel(repository: repository))
}

#Preview("Error") {
    let repository = MockCatsRepository()
    repository.result = .failure(CatsError.networkError)
    return CatsFeedView(viewModel: CatsFeedViewModel(repository: repository))
}
