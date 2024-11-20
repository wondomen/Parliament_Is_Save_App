//
//  MPs_Category.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 15.11.2024.
//

import Foundation
import SwiftUI

struct PartySelection: Identifiable {
    let id: String  // Use the party name as the unique identifier
}

struct MPs_CategoryView: View {
    @EnvironmentObject var preferences: Preferences
    @Environment(\.modelContext) private var context  // Access SwiftData context
    var members: [Member]

    // Group members by their party
    var groupedByParty: [String: [Member]] {
        Dictionary(grouping: members, by: { $0.party })
    }

    @State private var selectedParty: PartySelection? = nil  // Use PartySelection for Identifiable conformance

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(groupedByParty.keys.sorted(), id: \.self) { partyName in
                        VStack {
                            // Button to select a party
                            Button(action: {
                                selectedParty = PartySelection(id: partyName)
                            }) {
                                VStack {
                                    Image(partyName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
                                        .padding()

                                    Text(partyName)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: 150)

                            // Favorite toggle button (star)
                            Button(action: {
                                preferences.toggleFavoriteParty(partyName, context: context)
                            }) {
                                Image(systemName: preferences.favoriteParties.contains(partyName) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .padding(.top, 8)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Parties")
            // Present a sheet when a party is selected
            .sheet(item: $selectedParty) { partySelection in
                if let members = groupedByParty[partySelection.id] {
                    PartyMembersView(
                        party: partySelection.id,
                        members: members
                    )
                }
            }
        }
    }
}
