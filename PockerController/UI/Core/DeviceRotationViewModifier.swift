//
//  DeviceRotationViewModifier.swift
//  PockerController
//
//  Created by Anton Votinov on 25.02.2023.
//

import Foundation
import SwiftUI

struct DeviceRotationViewModifier: ViewModifier {
    let action: (Bool) -> Void;
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation.isPortrait)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (Bool) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
