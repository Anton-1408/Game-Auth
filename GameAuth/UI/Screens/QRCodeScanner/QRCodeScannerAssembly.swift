//
//  WelcomeAssembly.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import Foundation


final class QRCodeScannerAssembly {
    func build() -> QrCodeScannerView {
        let router = GuestRouter.shared
        let viewModel = QrCodeScannerViewModel(router: router)

        return QrCodeScannerView(viewModel: viewModel)
    }
}
