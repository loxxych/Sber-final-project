import Foundation

struct FetchCoinsUseCase {
    let repository: CoinsRepositoryProtocol

    func execute() async throws -> [Coin] {
        try await repository.fetchCoins()
    }
}
