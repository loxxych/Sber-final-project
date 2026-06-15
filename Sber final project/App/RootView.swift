import SwiftUI

struct RootView: View {
    @State private var sessionManager: SessionManager
    private let container: AppContainer

    init(container: AppContainer) {
        self.container = container
        _sessionManager = State(initialValue: container.sessionManager)
    }

    var body: some View {
        Group {
            if sessionManager.isAuthenticated {
                MainTabView(
                    coinsListViewModelFactory: container.makeCoinsListViewModel,
                    favoritesViewModelFactory: container.makeFavoritesViewModel,
                    detailViewModelFactory: container.makeCoinDetailViewModel(for:)
                )
            } else {
                AuthScreen(sessionManager: sessionManager)
            }
        }
        .animation(.default, value: sessionManager.isAuthenticated)
    }
}
