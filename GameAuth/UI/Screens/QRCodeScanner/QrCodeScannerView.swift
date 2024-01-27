import Foundation
import MercariQRScanner
import SwiftUI

struct QrCodeScannerView: UIViewControllerRepresentable {
    class Coordinator: NSObject, QRScannerViewDelegate {
        var parent: QrCodeScannerView;
        
        init(_ parent: QrCodeScannerView) {
            self.parent = parent
        }
   
        func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {}

        func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
            parent.viewModel.joingToTheGame(code)
        }
    }

    @ObservedObject var viewModel: QrCodeScannerViewModel;

    typealias QRCodeViewController = QRCodeScannerController
    
    func makeUIViewController(context: Context) -> QRCodeScannerController {
        let qrCodeController = QRCodeScannerController(coordinator: context.coordinator)
        
        return qrCodeController
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: QRCodeScannerController, context: Context) {}
}
