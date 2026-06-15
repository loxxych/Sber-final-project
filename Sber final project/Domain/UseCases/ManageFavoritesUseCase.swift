import Foundation

struct ManageFavoritesUseCase {
    let repository: FavoritesRepositoryProtocol

    func fetchAll() throws -> [Coin] {
        try repository.fetchAll()
    }

    func toggle(_ coin: Coin) throws {
        if repository.isFavorite(id: coin.id) {
            try repository.remove(id: coin.id)
        } else {
            try repository.add(coin)
        }
    }

    func remove(id: String) throws {
        try repository.remove(id: id)
    }

    func isFavorite(id: String) -> Bool {
        repository.isFavorite(id: id)
    }
}
