//
//  Header.swift
//  PockerController
//
//  Created by Anton Votinov on 20.03.2023.
//

import SwiftUI

struct Header: View {
    let handlerSignOut: () -> Void
    
    @ObservedObject private var store = Store.getStore()
    
    var body: some View {
        let websocketTrigger = WebSocketTrigger()
        let dailyTalkController = getDailyController(store.state)
        
        HStack(alignment: .center) {
            IconButton(
                handlePress: handlerSignOut,
                backgroundColor: Secondary.Dark,
                icon: "Exit"
            )
            Spacer()
            Text("Wait for the invitation to the game")
                .font(Typography.Subhead_1_Hardware_Condensed_26px_32)
                .foregroundColor(GrayScale.White)
            Spacer()
            DailyController(
                handleMicrophonePress: {
                    websocketTrigger.changeCamera(isCamera: !dailyTalkController.isCamera)
                },
                handleCameraPress: {
                    websocketTrigger.changeCamera(isCamera: !dailyTalkController.isCamera)
                },
                isMiscrophoneOn: dailyTalkController.isAudio,
                isCameraOn: dailyTalkController.isCamera
            )
        }
        .frame(maxWidth: .infinity)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(handlerSignOut: {})
    }
}
