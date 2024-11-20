//
//  FavoriteManager.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 12.11.2024.
//

import SwiftData

@Model
class Favorite: Identifiable {
    @Attribute(.unique) var id: Int  // Unique ID for MPs
    @Attribute(.unique) var party: String?  // Optional for favorite parties

    init(id: Int) {
        self.id = id
        self.party = nil
    }

    init(party: String) {
        self.id = -1  // Use -1 for parties (not tied to a specific MP)
        self.party = party
    }
}
