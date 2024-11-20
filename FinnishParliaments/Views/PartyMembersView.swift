//
//  PartyMembersView.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 19.11.2024.
//

import SwiftUI

import SwiftUI

struct PartyMembersView: View {
    var party: String
    var members: [Member]
    
    var body: some View {
        List(members) { member in
            HStack {
                // Display member's party logo or a fallback
                Image(member.party)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())

                // Display member details
                VStack(alignment: .leading) {
                    Text("\(member.first) \(member.last)")
                        .font(.headline)
                    
                    Text(member.constituency)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("\(party) Members")
    }
}
