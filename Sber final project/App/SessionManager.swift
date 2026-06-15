import Foundation
import Observation

@MainActor
@Observable
final class SessionManager {
    @ObservationIgnored private let userDefaults: UserDefaults
    @ObservationIgnored private let nameKey = "session.userName"

    private(set) var currentUserName: String?

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.currentUserName = userDefaults.string(forKey: nameKey)
    }

    var isAuthenticated: Bool { currentUserName != nil }

    func login(name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        userDefaults.set(trimmed, forKey: nameKey)
        currentUserName = trimmed
    }

    func logout() {
        userDefaults.removeObject(forKey: nameKey)
        currentUserName = nil
    }
}
