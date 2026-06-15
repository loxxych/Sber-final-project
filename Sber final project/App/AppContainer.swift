import Foundation
import SwiftData

@MainActor
final class AppContainer {
    let modelContainer: ModelContainer
    let sessionManager: SessionManager

    private let coinsRepository: CoinsRepositoryProtocol
    private let favoritesRepository: FavoritesRepositoryProtocol

    init() throws {
        let schema = Schema([FavoriteCoinModel.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        self.modelContainer = try ModelContainer(for: schema, configurations: [configuration])

        self.sessionManager = SessionManager()
        self.coinsRepository = CoinsRepository(apiClient: APIClient())
        self.favoritesRepository = FavoritesRepository(context: modelContainer.mainContext)
    }

    func makeCoinsListViewModel() -> CoinsListViewModel {
        CoinsListViewModel(useCase: FetchCoinsUseCase(repository: coinsRepository))
    }

    func makeFavoritesViewModel() -> FavoritesViewModel {
        FavoritesViewModel(useCase: ManageFavoritesUseCase(repository: favoritesRepository))
    }

    func makeCoinDetailViewModel(for coin: Coin) -> CoinDetailViewModel {
        CoinDetailViewModel(
            coin: coin,
            useCase: ManageFavoritesUseCase(repository: favoritesRepository)
        )
    }
}
