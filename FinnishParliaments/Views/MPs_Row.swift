//
//  MPs_Row.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//

import SwiftUI

struct MPs_Row: View {
    var member: Member
    @Binding var favorites: Set<Int>
    var isFavorite: Bool {
        favorites.contains(member.id)
    }
    var body: some View {
        HStack {
            member.image
                .resizable()
                .frame(width: 50, height: 50)
            Text("\(member.first) \(member.last)")
            
            Spacer()
            // Favorite star button
            Button(action: {
                if isFavorite {
                    favorites.remove(member.id)
                }else {
                    favorites.insert(member.id)
                }
            }) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

#Preview {
    @State var favoriteIds = Set<Int>()

    Group {
        MPs_Row(member: members[0], favorites: $favoriteIds)
        MPs_Row(member: members[1], favorites: $favoriteIds)
        MPs_Row(member: members[2], favorites: $favoriteIds)
        MPs_Row(member: members[3], favorites: $favoriteIds)
    }
}
