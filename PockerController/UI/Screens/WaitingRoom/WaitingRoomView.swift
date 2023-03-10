//
//  WaitingRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI

struct WaitingRoomView: View {
    @ObservedObject var viewModel: WaitingRoomViewModel;
    var body: some View {
        VStack {
            Text("Waiting Room")
        }
    }
    
}

struct WaitingRoomView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomAssembly().build()
    }
}
