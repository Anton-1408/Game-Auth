//
//  PokerApi.swift
//  PockerController
//
//  Created by Anton Votinov on 25.02.2023.
//

import Foundation

class PokerApi {
    private static var instance: PokerApi?

    var authToken: String?
    
    private var urlSession = URLSession.shared
    private var api: String = ""
    
    private struct DefaultError {
        static let title = "Error"
        static let message = "Something went wrong. Try again later"
    }

    private init() {
        if (apiKey != nil) {
            self.api = apiKey!
        }
    }
    
    public static func getInstance() -> PokerApi {
        if (instance == nil) {
            instance = PokerApi()
        }
        
        return instance!
    }

    public func scanQRCode(token: String, deviceInformation: QRCodeScanParams, handleError: @escaping (_ error: Error) -> Void, handleSuccess: @escaping (_ result: Response) -> Void) async {
        
        guard let url = URL(string: "\(api)/qr-code/scan") else {
            return
        }
        guard let body = try? JSONEncoder().encode(deviceInformation) else {
            return
        }
        
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "authorization")

        urlSession.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                let hasError = json?["code"]
                
                if (hasError != nil) {
                    let error = try JSONDecoder().decode(Error.self, from: data)
                    
                    handleError(error)
                    
                } else {
                    let gameData = try JSONDecoder().decode(Response.self, from: data)

                    self.authToken = gameData.authToken.access.token
                    
                    handleSuccess(gameData)
                }
                
            } catch {
                handleError(
                    .init(
                        title: DefaultError.title,
                        message: DefaultError.message
                    )
                )
            }
        }).resume()
    }

    public func getInformationForPlayers() async {}
}
