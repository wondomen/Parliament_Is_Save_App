//
//  MPs_Detail.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 4.11.2024.
//

import SwiftUI

struct MPs_Detail: View {
    var member: Member
    
    var body: some View {
        ScrollView {
            MPImage(image: member.image)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Parliament Member")
                        .font(.title)
                    Spacer()
                
                    Text("Party")
                        .font(.title)
                        
                }
                HStack {
                    Text("\(member.first), \(member.last)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(member.party)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                // Ministerial Status Section
                if member.minister {
                    HStack {
                        Image(systemName: "crown.fill") // Use an icon to represent minister status
                            .foregroundColor(.blue)
                        Text("Minister")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    .padding(.vertical, 4)
                }
                
                Divider()
                
                Text("About \(member.first), \(member.last)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("\(member.first) was born in \(member.bornYear) and is a member of the \(member.party) party, representing \(member.constituency) with seat number \(member.seatNumber).")
            }
            .padding()
        }
        .navigationTitle("\(member.last), \(member.first)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MPs_Detail(member: members[0])
}
