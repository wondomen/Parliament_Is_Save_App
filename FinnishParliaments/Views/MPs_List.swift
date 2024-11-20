//
//  MPs_List.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 4.11.2024.
//

import SwiftUI
import SwiftData

struct MPs_List: View {
    @Binding var members: [Member]  // List of MPs passed from parent view
    @EnvironmentObject var preferences: Preferences  // Access Preferences as an ObservableObject
    @Environment(\.modelContext) private var context  // Access SwiftData context

    @State private var showOnlyFavorites = false  // State for toggle

    // Filters the members based on the user's favorite MPs.
    var filteredMembers: [Member] {
        showOnlyFavorites ? members.filter { preferences.favoriteMPs.contains($0.id) } : members
    }

    var body: some View {
        NavigationView {
            VStack {
                // Toggle to switch between all MPs and favorite MPs
                Toggle("Show Only Favorites", isOn: $showOnlyFavorites)
                    .padding()

                // List of MPs (filtered if toggle is active)
                List(filteredMembers) { member in
                    NavigationLink {
                        MPs_Detail(member: member)  // Navigate to details view
                    } label: {
                        MPs_Row(
                            member: member,
                            favorites: preferences.favoriteMPs
                        ) {
                            preferences.toggleFavoriteMP(member.id, context: context)  // Add/remove favorite
                        }
                    }
                }
            }
            .navigationTitle("Members of Parliament")
        }
        .onAppear {
            // Load favorite MPs when the view appears
            preferences.loadFavorites(context: context)
        }
    }
}
