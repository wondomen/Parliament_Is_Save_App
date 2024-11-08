//
//  MPsScheme.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//

import Foundation
import SwiftUI
struct Member: Hashable, Codable, Identifiable {
    var personNumber: Int
    var seatNumber: Int
    var last: String
    var first: String
    var party: String
    var picture: String
    var minister: Bool
    var bornYear: Int
    var constituency: String
    
    var id: Int{
        personNumber
    }
    
    var image: Image{
        Image(party)
    }
}
