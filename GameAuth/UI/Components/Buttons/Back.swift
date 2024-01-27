//
//  Back.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import SwiftUI

struct Back: View {
    let handlePress: () -> Void
    
    var body: some View {
        Button(action: handlePress) {
            Image("Back")
            Text("Back")
                .foregroundColor(GrayScale.White)
                .font(Typography.Body_1_Gilroy_Medium_16px_20)
        }
        .padding()
    }
}
