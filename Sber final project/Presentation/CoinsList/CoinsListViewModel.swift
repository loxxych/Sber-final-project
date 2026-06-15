import Foundation
import Observation

@MainActor
@Observable
final class CoinsListViewModel {
    @ObservationIgnored private let useCase: FetchCoinsUseCase

    var coins: [Coin] = []
    var isLoading = false
    var errorMessage: String?

    init(useCase: FetchCoinsUseCase) {
        self.useCase = useCase
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            coins = try await useCase.execute()
        } catch {
            errorMessage = "Не удалось загрузить данные: \(error.localizedDescription)"
        }
    }
}
