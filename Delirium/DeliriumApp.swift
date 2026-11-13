import SwiftUI

@main
struct DeliriumApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

/// Owns navigation. Every screen is pushed straight from home, so every
/// screen is one tap from home and there are no nested menus.
struct RootView: View {
    @State private var path: [Screen] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView { screen in path = [screen] }
                .navigationDestination(for: Screen.self) { screen in
                    ScreenView(screen: screen) { path = [.nurse] }
                }
        }
    }
}
