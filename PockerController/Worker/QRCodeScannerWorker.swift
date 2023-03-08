//
//  QRCodeScannerWorker.swift
//  PockerController
//
//  Created by Anton Votinov on 08.03.2023.
//

import Foundation

final class QRCodeScannerWorker: ObservableObject {
    @Published var isLoading = true
    
    private let store = Store.getStore()
    private let api = Api.getInstance()
    
    public func signIn(token: String, deviceInformation: QRCodeScanParams) async {
        await self.api.scanQRCode(
            token: token,
            deviceInformation: deviceInformation,
            handleError: { error in
               print("error", error)
            },
            handleSuccess: { result in
                let authToken = result.authToken.access
                let userId = result.user.id
                let userName = result.user.name

                self.isLoading = false

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.store.dispath(.setAuthToken(
                        .init(
                            expires: authToken.expires,
                            token: authToken.token
                        )
                    ))
                    self.store.dispath(.setUser(
                        .init(
                            id: userId,
                            name: userName
                        )
                    ))
                }
            }
        )
    }
}
