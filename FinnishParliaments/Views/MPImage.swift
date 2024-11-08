//
//  MPImage.swift
//  FinnishParliaments
//
//  Created by Berhanu Muche on 3.11.2024.
//

import SwiftUI

struct MPImage: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)  // Adjust the size as needed
            .clipShape(Circle())             // Optional, use this if you want a circular image
            .shadow(radius: 10)              // Optional, for a shadow effect
    }
}

#Preview {
    MPImage(image: Image("kok"))
}
