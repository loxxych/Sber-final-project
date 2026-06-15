import Foundation
import Observation

@MainActor
@Observable
final class CoinDetailViewModel {
    @ObservationIgnored private let useCase: ManageFavoritesUseCase
    let coin: Coin
    var isFavorite: Bool

    init(coin: Coin, useCase: ManageFavoritesUseCase) {
        self.coin = coin
        self.useCase = useCase
        self.isFavorite = useCase.isFavorite(id: coin.id)
    }

    func toggleFavorite() {
        do {
            try useCase.toggle(coin)
            isFavorite = useCase.isFavorite(id: coin.id)
        } catch {
            // intentionally swallowed — UI state will be re-synced on next read
        }
    }

    func refreshFavoriteState() {
        isFavorite = useCase.isFavorite(id: coin.id)
    }
}
