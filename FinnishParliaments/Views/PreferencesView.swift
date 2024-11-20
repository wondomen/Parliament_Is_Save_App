//
//  PreferencesView.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 19.11.2024.
//

import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var preferences: Preferences  // Access Preferences via EnvironmentObject
    var members: [Member]  // The list of MPs passed from the parent view
    
    // Filter favorite MPs using preferences.favoriteMPs
    var favoriteMembers: [Member] {
        members.filter { preferences.favoriteMPs.contains($0.id) }
    }
    
    var body: some View {
        NavigationView {
            List {
                // Display favorite parties
                Section(header: Text("Favorite Parties")) {
                    ForEach(preferences.favoriteParties.sorted(), id: \.self) { party in
                        HStack {
                            Image(party)  // Assumes the image name in the asset is exactly the same as the party name
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            
                            Text(party)
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                // Display favorite MPs
                Section(header: Text("Favorite MPs")) {
                    if favoriteMembers.isEmpty {
                        Text("No favorite MPs yet")
                            .foregroundColor(.gray)
                    } else {
                        ForEach(favoriteMembers) { member in
                            HStack {
                                member.image
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text("\(member.first) \(member.last)")
                                        .font(.headline)
                                    Text(member.party)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Preferences")
        }
    }
}
