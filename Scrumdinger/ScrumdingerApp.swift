import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            fatalError("Error saving scrums.")
                        }
                    }
                }
            }
            .onAppear {
                Task{
                    do {
                        store.scrums = try await ScrumStore.load()
                    } catch {
                        fatalError("Error load scrums.")
                    }
                }
            }
        }
    }
}
