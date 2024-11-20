//
//  FinnishParliamentsApp.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//

import SwiftUI
import SwiftData

@main
struct FinnishParliamentsApp: App {
    @StateObject private var preferences = Preferences()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(preferences)
                .modelContainer(for: Favorite.self)  // Initialize SwiftData container
        }
    }
}

