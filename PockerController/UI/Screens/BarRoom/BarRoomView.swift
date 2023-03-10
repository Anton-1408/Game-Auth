//
//  BarRoomView.swift
//  PockerController
//
//  Created by Anton Votinov on 10.03.2023.
//

import SwiftUI

struct BarRoomView: View {
    @ObservedObject var viewModel: BarRoomViewModel;
    
    var body: some View {
        Text("Bar room")
    }
}

struct BarRoomView_Previews: PreviewProvider {
    static var previews: some View {
        BarRoomAssembly().build()
    }
}
