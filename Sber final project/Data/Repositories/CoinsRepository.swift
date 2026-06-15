import Foundation

final class CoinsRepository: CoinsRepositoryProtocol {
    private let apiClient: APIClientProtocol
    private let mockBundle: Bundle

    private let endpoint = URL(
        string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false&price_change_percentage=24h"
    )!

    init(apiClient: APIClientProtocol, mockBundle: Bundle = .main) {
        self.apiClient = apiClient
        self.mockBundle = mockBundle
    }

    func fetchCoins() async throws -> [Coin] {
        do {
            let dtos: [CoinDTO] = try await apiClient.fetch(endpoint)
            return dtos.map { $0.toDomain() }
        } catch {
            return try loadFromBundle()
        }
    }

    private func loadFromBundle() throws -> [Coin] {
        guard let url = mockBundle.url(forResource: "coins", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        let data = try Data(contentsOf: url)
        let dtos = try JSONDecoder().decode([CoinDTO].self, from: data)
        return dtos.map { $0.toDomain() }
    }
}
