import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class FavoritesViewModel {
    @ObservationIgnored private let useCase: ManageFavoritesUseCase
    var favorites: [Coin] = []

    init(useCase: ManageFavoritesUseCase) {
        self.useCase = useCase
    }

    func reload() {
        favorites = (try? useCase.fetchAll()) ?? []
    }

    func remove(at offsets: IndexSet) {
        let ids = offsets.map { favorites[$0].id }
        for id in ids {
            try? useCase.remove(id: id)
        }
        favorites.remove(atOffsets: offsets)
    }
}
