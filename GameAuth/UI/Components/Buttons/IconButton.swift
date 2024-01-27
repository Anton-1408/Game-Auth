//
//  IconButton.swift
//  PockerController
//
//  Created by Anton Votinov on 18.03.2023.
//

import SwiftUI

struct IconButton: View {
    let handlePress: () -> Void
    let backgroundColor: Color
    let icon: String
    
    var body: some View {
        Button(action: handlePress) {
            Image(icon)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .frame(width: 40, height: 40)
        .background(backgroundColor)
        .cornerRadius(8)
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(handlePress: {}, backgroundColor: Secondary.Dark, icon: "Exit")
    }
}
