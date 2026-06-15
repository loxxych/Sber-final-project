import Foundation
import SwiftData

@MainActor
final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchAll() throws -> [Coin] {
        let descriptor = FetchDescriptor<FavoriteCoinModel>(
            sortBy: [SortDescriptor(\.addedAt, order: .reverse)]
        )
        return try context.fetch(descriptor).map { $0.toDomain }
    }

    func add(_ coin: Coin) throws {
        guard !isFavorite(id: coin.id) else { return }
        context.insert(FavoriteCoinModel.make(from: coin))
        try context.save()
    }

    func remove(id: String) throws {
        let descriptor = FetchDescriptor<FavoriteCoinModel>(
            predicate: #Predicate { $0.id == id }
        )
        let models = try context.fetch(descriptor)
        models.forEach { context.delete($0) }
        try context.save()
    }

    func isFavorite(id: String) -> Bool {
        let descriptor = FetchDescriptor<FavoriteCoinModel>(
            predicate: #Predicate { $0.id == id }
        )
        return ((try? context.fetchCount(descriptor)) ?? 0) > 0
    }
}
