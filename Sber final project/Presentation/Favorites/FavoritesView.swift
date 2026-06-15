import SwiftUI

struct FavoritesView: View {
    @State private var viewModel: FavoritesViewModel
    private let detailViewModelFactory: (Coin) -> CoinDetailViewModel

    init(
        viewModel: @autoclosure @escaping () -> FavoritesViewModel,
        detailViewModelFactory: @escaping (Coin) -> CoinDetailViewModel
    ) {
        _viewModel = State(initialValue: viewModel())
        self.detailViewModelFactory = detailViewModelFactory
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Избранное")
                .onAppear { viewModel.reload() }
                .navigationDestination(for: Coin.self) { coin in
                    CoinDetailView(viewModel: detailViewModelFactory(coin))
                        .onDisappear { viewModel.reload() }
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.favorites.isEmpty {
            ContentUnavailableView(
                "Пока пусто",
                systemImage: "star",
                description: Text("Добавьте монеты из списка, чтобы они появились здесь")
            )
        } else {
            List {
                ForEach(viewModel.favorites) { coin in
                    NavigationLink(value: coin) {
                        CoinRowView(coin: coin)
                    }
                }
                .onDelete(perform: viewModel.remove)
            }
            .listStyle(.plain)
        }
    }
}
