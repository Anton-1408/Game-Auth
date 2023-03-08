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
    private let api: Api
    
    init(qrCodeData: String, router: GuestRouter) {
        self.qrCodeData = qrCodeData
        self.router = router
        self.api = Api.getInstance()
    }
    
    public func goToWelcomeScreen() {
        router.goToRoot()
    }
    
    public func sendQrCode(deviceModel: String, deviceVersion: String, deviceName: String, handleError: @escaping (_ error: Error) -> Void, handleSuccess: @escaping (_ result: Response) -> Void) async {
        await self.api.scanQRCode(
            token: qrCodeData,
            deviceInformation: .init(
            deviceInformation: .init(
               deviceName: deviceName,
               deviceOS: "IOS",
               deviceModel: deviceModel,
               deviceVersion: deviceVersion
            )),
            handleError: handleError,
            handleSuccess: handleSuccess
        )
    }
}
                                  
