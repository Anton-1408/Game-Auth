//
//  RoomJoingToTheGameViewModel.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import Foundation

final class RoomJoingToTheGameViewModel: ObservableObject {
    @Published var qrCodeData: String;

    private let router: GuestRouter
    private let api: PokerApi
    
    init(qrCodeData: String, router: GuestRouter) {
        self.qrCodeData = qrCodeData
        self.router = router
        self.api = PokerApi.getInstance()
    }
    
    public func goToWelcomeScreen() {
        router.goToRoot()
    }
    
    public func sendQrCode(deviceModel: String, deviceVersion: String, deviceName: String) async {
        let deviceOS = "IOS";
        
        await self.api.scanQRCode(
            token: qrCodeData,
            deviceInformation: .init(
            deviceInformation: .init(
               deviceName: deviceName,
               deviceOS: deviceOS,
               deviceModel: deviceModel,
               deviceVersion: deviceVersion
            )),
            handleError: {error in
              print("error", error)
            },
            handleSuccess: {success in
               print("success", success)
            }
        )
    }
}
                                  
