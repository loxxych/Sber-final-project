import Foundation

protocol FavoritesRepositoryProtocol {
    func fetchAll() throws -> [Coin]
    func add(_ coin: Coin) throws
    func remove(id: String) throws
    func isFavorite(id: String) -> Bool
}
