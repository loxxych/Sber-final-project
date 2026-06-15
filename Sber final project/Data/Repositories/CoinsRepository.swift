import Foundation

final class CoinsRepository: CoinsRepositoryProtocol {
    private let apiClient: APIClientProtocol

    private let endpoint = URL(
        string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&price_change_percentage=24h"
    )!

    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }

    func fetchCoins() async throws -> [Coin] {
        let dtos: [CoinDTO] = try await apiClient.fetch(endpoint)
        return dtos.map { $0.toDomain() }
    }
}
