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
            ZStack {
                Color.accent.opacity(0.4)
                    .ignoresSafeArea()
                switch viewModel.viewState {
                case .firstLoad:
                    firstLoadView
                case .data:
                    scrollableCats()
                case .empty:
                    emptyView
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

    // MARK: - First Load

    private var firstLoadView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                .scaleEffect(1.5)
            Text("Fetching adorable cats... 🐱")
                .font(.headline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Feed View

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

    // MARK: - Empty View

    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "cat")
                .font(.largeTitle)
            Text("The cats can't come out right now.\n Hit the reload button.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .font(.title)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            Image(systemName: "arrow.clockwise")
                .font(.largeTitle)
                .foregroundStyle(.accent)
                .padding()
                .anyButton(.press) {
                    onRefreshPressed()
                }
        }
    }

    // MARK: - Actions

    private func onInteractionsPressed() {
        if let scrollPosition = viewModel.scrollPosition {
            viewModel.interactWithCat(currentCatId: scrollPosition)
        }
    }
    private func onRefreshPressed() {
        Task {
            await viewModel.getCatsFeed(forceReload: true)
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
