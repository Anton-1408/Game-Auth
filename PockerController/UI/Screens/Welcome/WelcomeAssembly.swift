//
//  WelcomeAssembly.swift
//  PockerController
//
//  Created by Anton Votinov on 24.02.2023.
//

import Foundation


final class WelcomeAssembly {
    func build() -> WelcomeView {
        let router = GuestRouter.shared
        let viewModel = WelcomeViewModel(router: router)

        return WelcomeView(viewModel: viewModel)
    }
}
