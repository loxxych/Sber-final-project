import SwiftUI

struct CoinsListView: View {
    @State private var viewModel: CoinsListViewModel
    private let detailViewModelFactory: (Coin) -> CoinDetailViewModel

    init(
        viewModel: @autoclosure @escaping () -> CoinsListViewModel,
        detailViewModelFactory: @escaping (Coin) -> CoinDetailViewModel
    ) {
        _viewModel = State(initialValue: viewModel())
        self.detailViewModelFactory = detailViewModelFactory
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Криптовалюты")
                .task {
                    if viewModel.coins.isEmpty {
                        await viewModel.load()
                    }
                }
                .refreshable {
                    await viewModel.load()
                }
                .navigationDestination(for: Coin.self) { coin in
                    CoinDetailView(viewModel: detailViewModelFactory(coin))
                }
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.coins.isEmpty {
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage, viewModel.coins.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundStyle(.orange)
                Text(error)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                Button("Повторить") {
                    Task { await viewModel.load() }
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List(viewModel.coins) { coin in
                NavigationLink(value: coin) {
                    CoinRowView(coin: coin)
                }
            }
            .listStyle(.plain)
        }
    }
}
