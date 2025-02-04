//
//  MainView.swift
//  AnotherCatsApp
//
//  Created by Javier Heisecke on 2025-02-03.
//

import SwiftUI

struct CatsFeedView: View {

    @State private var selectedCat: CatModel?
    @State var viewModel: CatsFeedViewModel

    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .firstLoad:
                    SkeletonHeroCellView()
                        .ignoresSafeArea()
                case .data:
                    scrollableCats()
                        .ignoresSafeArea()
                        .background(Color.accent.opacity(0.4))
                case .empty:
                    NoCatsView {
                        await viewModel.getCatsFeed()
                    }
                }
            }
            .showCustomAlert(alert: $viewModel.showAlert)
            .navigationDestination(isPresented: Binding(ifNotNil: $selectedCat)) {
                if let selectedCat {
                    CatDetailView(
                        cat: selectedCat
                    )
                }
            }

        }
        .task {
            await viewModel.getCatsFeed()
        }
    }

    private func scrollableCats() -> some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.cats) { cat in
                        HeroCellView(
                            title: cat.breeds,
                            subtitle: cat.personality,
                            imageName: cat.imageUrl
                        )
                        .frame(maxWidth: .infinity)
                        .containerRelativeFrame(.vertical, alignment: .center)
                        .id(cat.id)
                        .anyButton {
                            selectedCat = cat
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollBounceBehavior(.basedOnSize)
            .scrollDisabled(true)
            .scrollPosition(id: $viewModel.scrollPosition, anchor: .center)
            .animation(.default, value: viewModel.scrollPosition)
            InteractionsView {
                if let scrollPosition = viewModel.scrollPosition {
                    viewModel.interactWithCat(currentCatId: scrollPosition)
                }
            }
            .padding(.bottom)
        }
    }
}

#Preview("Feed with Images") {
    let repository = MockCatsRepository()
    repository.result = .success(CatsListResponse.mocks)
    return CatsFeedView(viewModel: CatsFeedViewModel(repository: repository))
}

#Preview("Empty State") {
    CatsFeedView(viewModel: CatsFeedViewModel(repository: MockCatsRepository()))
}

#Preview("Error") {
    let repository = MockCatsRepository()
    repository.result = .failure(CatsError.networkError)
    return CatsFeedView(viewModel: CatsFeedViewModel(repository: repository))
}
