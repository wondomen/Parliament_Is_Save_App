//
//  ContentView.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//
import SwiftUI

struct ContentView: View {
    @State private var members: [Member] = []  // This will hold the list of MPs.
    @State private var isLoading = true  // Loading indicator.
    @StateObject private var preferences = Preferences()  // Preferences for favorites.

    var body: some View {
        TabView {
            MPs_List(members: $members)  // Pass the members as a binding to MPs_List
                .tabItem {
                    Label("MPs", systemImage: "person.3")
                }

            MPs_CategoryView(members: members)  // Display MPs by category (not shown in your provided code)
                .tabItem {
                    Label("By Party", systemImage: "list.bullet.rectangle")
                }

            PreferencesView(members: members)  // A view for settings/preferences (not shown in your provided code)
                .tabItem {
                    Label("Preferences", systemImage: "gearshape")
                }
        }
        .environmentObject(preferences)
        .onAppear {
            loadMembers()  // Load MPs when the view appears
        }
    }

    // Load the MPs data using the MpsDataLoader
    private func loadMembers() {
        MpsDataLoader.loadMps { fetchedMembers in
            if let fetchedMembers = fetchedMembers {
                self.members = fetchedMembers  // Assign the fetched MPs to the members array
                self.isLoading = false  // Stop loading
            } else {
                print("Failed to load MPs data.")
                self.isLoading = false  // Stop loading even if there's an error
            }
        }
    }
}
