import SwiftUI
import Firebase
@main
struct MainApp: App {
    init() {
        // configuring Firebase
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(FirebaseEnv())
                .environmentObject(UserEnv())
                .environmentObject(VideoEnv())
                .accentColor(Color.theme.blue)
        }
    }
}
