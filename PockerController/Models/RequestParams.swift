//
//  RequestParams.swift
//  PockerController
//
//  Created by Anton Votinov on 25.02.2023.
//

import Foundation

struct QRCodeScanParams: Encodable {
    var deviceInformation: DeviceInformation
    
    struct DeviceInformation: Encodable {
      var deviceName: String
      var deviceOS: String
      var deviceModel: String
      var deviceVersion: String
    }
}
