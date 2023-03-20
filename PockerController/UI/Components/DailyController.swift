//
//  DailyController.swift
//  PockerController
//
//  Created by Anton Votinov on 20.03.2023.
//

import SwiftUI

struct DailyController: View {
    let handleMicrophonePress: () -> Void
    let handleCameraPress: () -> Void
    
    let isMiscrophoneOn: Bool
    let isCameraOn: Bool
    
    var body: some View {
        let microphoneIcon = isMiscrophoneOn ? "Microphone" : "MicrophoneOff"
        let cameraIcon = isCameraOn ? "Camera" : "CameraOff"
        
        let backgroundCamera = isCameraOn ? Primary.Default : GrayScale.White
        let backgroundMicrophone = isMiscrophoneOn ? Primary.Default : GrayScale.White
        
        HStack {
            IconButton(
                handlePress: handleMicrophonePress,
                backgroundColor: backgroundMicrophone,
                icon: microphoneIcon
            )
            
            IconButton(
                handlePress: handleCameraPress,
                backgroundColor: backgroundCamera,
                icon: cameraIcon
            )
        }
    }
}

struct DailyController_Previews: PreviewProvider {
    static var previews: some View {
        DailyController(
            handleMicrophonePress: {}, handleCameraPress: {},
            isMiscrophoneOn: false,
            isCameraOn: true
        )
    }
}
