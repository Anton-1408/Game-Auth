//
//  GameRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI

struct GameRoomView: View {
    @ObservedObject var viewModel: GameRoomViewModel
    
    var body: some View {
        Text("Game room")
    }
}

struct GameRoomView_Previews: PreviewProvider {
    static var previews: some View {
        GameRoomAssembly().build()
    }
}
