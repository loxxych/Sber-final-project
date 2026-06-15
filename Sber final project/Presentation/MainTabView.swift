import SwiftUI

struct MainTabView: View {
    let coinsListViewModelFactory: () -> CoinsListViewModel
    let favoritesViewModelFactory: () -> FavoritesViewModel
    let detailViewModelFactory: (Coin) -> CoinDetailViewModel

    var body: some View {
        TabView {
            CoinsListView(
                viewModel: coinsListViewModelFactory(),
                detailViewModelFactory: detailViewModelFactory
            )
            .tabItem {
                Label("Монеты", systemImage: "bitcoinsign.circle")
            }

            FavoritesView(
                viewModel: favoritesViewModelFactory(),
                detailViewModelFactory: detailViewModelFactory
            )
            .tabItem {
                Label("Избранное", systemImage: "star")
            }
        }
    }
}
