//
//  MPs_Row.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//

import SwiftUI

struct MPs_Row: View {
    var member: Member
    var favorites: Set<Int>
    var toggleFavorite: () -> Void  // Callback for toggling favorites

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
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
