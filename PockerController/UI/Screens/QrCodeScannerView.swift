import Foundation
import MercariQRScanner
import SwiftUI

struct QrCodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, QRScannerViewDelegate {
        func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
            print("error", error)
        }

        func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
            print("success", code)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    typealias QRCodeViewController = QRCodeScannerController
    
    func makeUIViewController(context: Context) -> QRCodeScannerController {
        let qrCodeController = QRCodeScannerController()
        
        qrCodeController.setDelegate(coordinator: context.coordinator)
        
        return qrCodeController
    }
    
    func updateUIViewController(_ uiViewController: QRCodeScannerController, context: Context) {}
}
