import Foundation

protocol CoinsRepositoryProtocol {
    func fetchCoins() async throws -> [Coin]
}
