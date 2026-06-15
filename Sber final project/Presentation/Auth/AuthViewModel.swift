import Foundation

@MainActor
final class AuthViewModel {
    static let minNameLength = 3

    private let sessionManager: SessionManager
    private(set) var name: String = ""

    var onValidityChanged: ((Bool) -> Void)?

    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }

    func updateName(_ name: String) {
        self.name = name
        onValidityChanged?(isValid)
    }

    var isValid: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).count >= Self.minNameLength
    }

    func submit() {
        guard isValid else { return }
        sessionManager.login(name: name)
    }
}
