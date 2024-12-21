//___FILEHEADER___

import SwiftUI
import SwiftData

@main
struct ___PACKAGENAME: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for:Friends.self)
        }
    }
}
