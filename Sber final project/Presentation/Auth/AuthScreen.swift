import SwiftUI
import UIKit

struct AuthScreen: UIViewControllerRepresentable {
    let sessionManager: SessionManager

    func makeUIViewController(context: Context) -> AuthViewController {
        let viewModel = AuthViewModel(sessionManager: sessionManager)
        return AuthViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: AuthViewController, context: Context) {}
}
