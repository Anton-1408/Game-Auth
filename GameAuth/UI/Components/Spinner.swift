//
//  Spinner.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import Foundation
import SwiftUI

enum TypeSpinner: String {
    case LineSpinner
    case GoldSpinner
    case WhiteSpinner
}

struct Spinner: View {
    let typeSpinner: TypeSpinner
    
    @State private var isRotating: Double = 0.0

    var body: some View {
        VStack {
            Image(typeSpinner.rawValue)
                .rotationEffect(.degrees(isRotating))
        }.onAppear{
            withAnimation(.linear(duration: 1).speed(0.4).repeatForever(autoreverses: false)) {
                isRotating = 360.0
            }
        }
    }
}
