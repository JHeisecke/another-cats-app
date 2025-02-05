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
                    NoCatsView(reload: viewModel.getCatsFeed)
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
                LazyVStack(spacing: 0) {
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
                            onCatPressed(cat)
                        }
                        .accessibilityIdentifier(AccessibilityIdentifiers.catImage(cat.id))
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
                onInteractionsPressed()
            }
            .padding(.bottom)
        }
    }

    // MARK: - Actions

    private func onInteractionsPressed() {
        if let scrollPosition = viewModel.scrollPosition {
            viewModel.interactWithCat(currentCatId: scrollPosition)
        }
    }

    private func onCatPressed(_ cat: CatModel) {
        selectedCat = cat
    }
}

// MARK: - Previews

#Preview("Feed with Images") {
    let repository = CatsRepository(apiClient: MockAPIClient())
    return CatsFeedView(viewModel: CatsFeedViewModel(repository: repository))
}

#Preview("Empty State") {
    let repository = CatsRepository(apiClient: MockAPIClient())
    CatsFeedView(viewModel: CatsFeedViewModel(repository: repository, page: 2, limit: 0))
}

#Preview("Error") {
    let repository = CatsRepository(apiClient: MockAPIClient())
    CatsFeedView(viewModel: CatsFeedViewModel(repository: repository, page: 2, limit: 10))
}
