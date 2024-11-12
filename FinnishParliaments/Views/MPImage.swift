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
            .frame(width: 200, height: 200)
            .clipShape(Circle())
            .shadow(radius: 10)      
    }
}

#Preview {
    MPImage(image: Image("kok"))
}
