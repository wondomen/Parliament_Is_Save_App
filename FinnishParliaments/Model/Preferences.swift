//
//  Preferences.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//

import Foundation
import SwiftUI
import SwiftData

class Preferences: ObservableObject {
    @Published var favoriteMPs: Set<Int> = []
    @Published var favoriteParties: Set<String> = []

    /// Load favorites from SwiftData.
    func loadFavorites(context: ModelContext) {
        let fetchRequest = FetchDescriptor<Favorite>()
        do {
            let favorites = try context.fetch(fetchRequest)
            favoriteMPs = Set(favorites.compactMap { $0.id })
            favoriteParties = Set(favorites.compactMap { $0.party })
        } catch {
            print("Failed to fetch favorites: \(error.localizedDescription)")
        }
    }

    // Toggle an MP as a favorite.
    
    func toggleFavoriteMP(_ id: Int, context: ModelContext) {
        if favoriteMPs.contains(id) {
            favoriteMPs.remove(id)
            removeFavorite(id: id, context: context)
        } else {
            favoriteMPs.insert(id)
            saveFavoriteMP(id, context: context)
        }
    }

    // Toggle a party as a favorite.
    func toggleFavoriteParty(_ party: String, context: ModelContext) {
        if favoriteParties.contains(party) {
            favoriteParties.remove(party)
            removeFavorite(party: party, context: context)
        } else {
            favoriteParties.insert(party)
            saveFavoriteParty(party, context: context)
        }
    }

    private func saveFavoriteMP(_ id: Int, context: ModelContext) {
        do {
            let newFavorite = Favorite(id: id)
            context.insert(newFavorite)
            try context.save()
        } catch {
            print("Failed to save favorite MP: \(error.localizedDescription)")
        }
    }

    // Save a favorite party to SwiftData.
    private func saveFavoriteParty(_ party: String, context: ModelContext) {
        do {
            let newFavorite = Favorite(party: party)  // Ensure 'party' is properly set here
            context.insert(newFavorite)
            try context.save()
        } catch {
            print("Failed to save favorite party: \(error.localizedDescription)")
        }
    }

    // Remove a favorite MP or party from SwiftData.
    private func removeFavorite(id: Int? = nil, party: String? = nil, context: ModelContext) {
        do {
            let fetchRequest = FetchDescriptor<Favorite>()
            let favorites = try context.fetch(fetchRequest)
            if let id = id, let favorite = favorites.first(where: { $0.id == id }) {
                context.delete(favorite)
            } else if let party = party, let favorite = favorites.first(where: { $0.party == party }) {
                context.delete(favorite)
            }
            try context.save()
        } catch {
            print("Failed to remove favorite: \(error.localizedDescription)")
        }
    }
}
