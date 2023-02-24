import Foundation
import MercariQRScanner
import AVFoundation

class QRCodeScannerController: UIViewController {
    private var qrScannerView: QRScannerView!;
    private var router = GuestRouter.shared;
    private var coordinator: QRScannerViewDelegate?;
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let icon = UIImage(named: "Back")
        
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setImage(icon, for: .normal)
        button.sizeToFit()
        button.imageView?.contentMode = .scaleAspectFit
        
        button.frame.origin = CGPoint(x: 0, y: 20)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var wrapView: UIView = {
        let wrapView = UIView()

        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        return wrapView;
    }()

    private lazy var flashButton: UIButton = {
        let button = UIButton()
        let flashOn = UIImage(named: "FlashOn")
        
        button.isSelected = false;
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(flashOn, for: .normal)
        button.sizeToFit()
        
        let left = UIDevice.current.orientation.isPortrait ? 60 : 150
        
        button.frame.origin = CGPoint(x: Int(UIScreen.main.bounds.width) - left, y: 20)
        
        button.addTarget(self, action: #selector(tapFlashButton), for: .touchUpInside)
        
        return button;
    }()
    
    @objc
    private func tapFlashButton(_ sender: UIButton) {
        let flashOn = UIImage(named: "FlashOn")
        let flashOff = UIImage(named: "FlashOff")
        
        let iconFlash = sender.isSelected ? flashOn : flashOff;
        
        sender.isSelected = !sender.isSelected;
        sender.setImage(iconFlash, for: .normal)
        
        qrScannerView.setTorchActive(isOn: sender.isSelected)
    }
    
    @objc
    private func goBack() {
        router.back()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let left = UIDevice.current.orientation.isPortrait ? 60 : 150
        
        if #available(iOS 16.0, *) {
            qrScannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            flashButton.frame.origin = CGPoint(x: Int(UIScreen.main.bounds.width) - left, y: 20)
        } else {
            qrScannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
            flashButton.frame.origin = CGPoint(x: Int(UIScreen.main.bounds.height) - left, y: 20)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCameraPermissions()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        wrapView.translatesAutoresizingMaskIntoConstraints = false
        
        let views : [String:Any] = ["wrapView":wrapView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[wrapView]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[wrapView]-|", options: [], metrics: nil, views: views))
    }
    
    private func getCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                startQrCodeScanner()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                    if granted {
                        DispatchQueue.main.async { [weak self] in
                            self?.startQrCodeScanner()
                        }
                    }
                }
            default:
                showAlert()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "QRCode scanning", message: "Don't have permissions.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            self.goBack()
        }))
    
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func startQrCodeScanner() {
        qrScannerView = QRScannerView(frame: view.bounds)
        qrScannerView.focusImage = UIImage(named: "FrameScanner")
        
        qrScannerView.configure(delegate: coordinator!)
        qrScannerView.startRunning()
        
        view.addSubview(qrScannerView)
        view.addSubview(wrapView)
        
        wrapView.addSubview(cancelButton)
        wrapView.addSubview(flashButton)
    }
    
    public func setDelegate(coordinator: QRScannerViewDelegate) {
        self.coordinator = coordinator
    }
}
