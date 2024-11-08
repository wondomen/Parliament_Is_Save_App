//
//  MPs_List.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 4.11.2024.
//

import SwiftUI

struct MPs_List: View {
    @State private var showOnlyFavorites = false  // Toggle state
    @State private var favorites = Set<Int>()     // Track favorite members by ID
    var filteredMembers: [Member] {
            showOnlyFavorites ? members.filter { favorites.contains($0.id) } : members
        }
    var body: some View {
        NavigationSplitView {
            VStack{
                Toggle("Show Only Favorites", isOn: $showOnlyFavorites)
                    .padding()
                
                List (filteredMembers) {member in
                    NavigationLink{
                        MPs_Detail(member: member)
                    }label:{
                        
                        MPs_Row(member: member, favorites: $favorites)
                    }
                }
                .navigationTitle("Memebers of Parliament")
            }
        }detail: {
            Text("Select MP's")
        }
    }
}

#Preview {
    MPs_List()
}
