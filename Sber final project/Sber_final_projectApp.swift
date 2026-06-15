import SwiftUI
import SwiftData

@main
struct Sber_final_projectApp: App {
    let container: AppContainer

    init() {
        do {
            self.container = try AppContainer()
        } catch {
            fatalError("Failed to initialize AppContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
                .modelContainer(container.modelContainer)
        }
    }
}
