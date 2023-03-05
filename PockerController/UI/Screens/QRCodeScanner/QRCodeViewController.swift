import Foundation
import MercariQRScanner
import AVFoundation

class QRCodeScannerController: UIViewController {
    private var router = GuestRouter.shared;
    private var coordinator: QRScannerViewDelegate?;
    
    convenience init(coordinator: QRScannerViewDelegate) {
        self.init();
        
        self.coordinator = coordinator
    }
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        let icon = UIImage(named: "Back")
        
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setImage(icon, for: .normal)
        button.sizeToFit()
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()

    private lazy var flashButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        
        configuration.imagePlacement = .trailing
        
        let button = UIButton(configuration: configuration)
        let flashOn = UIImage(named: "FlashOn")
        
        button.isSelected = false;
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(flashOn, for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(tapFlashButton), for: .touchUpInside)
        
        return button;
    }()
    
    private lazy var qrScannerView: QRScannerView = {
        let qrScannerView = QRScannerView(frame: view.bounds)
        
        qrScannerView.focusImage = UIImage(named: "FrameScanner")
        qrScannerView.configure(delegate: coordinator!)
        
        return qrScannerView;
    }()
    
    private lazy var viewButtons: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .fill

        stack.addArrangedSubview(cancelButton)
        stack.addArrangedSubview(flashButton)

        stack.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true

        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    @objc
    private func tapFlashButton(_ sender: UIButton) {
        let flashOn = UIImage(named: "FlashOn")
        let flashOff = UIImage(named: "FlashOff")
        
        let iconFlash = sender.isSelected ? flashOn : flashOff;
        
        sender.isSelected = !sender.isSelected;
        sender.setImage(iconFlash, for: .normal)
        sender.tintColor = .clear
  
        qrScannerView.setTorchActive(isOn: sender.isSelected)
    }
    
    @objc
    private func goBack() {
        router.back()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if #available(iOS 16.0, *) {
            qrScannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        } else {
            qrScannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCameraPermissions()
    }
    
    private func getCameraPermissions() {
        view.backgroundColor = UIColor(GrayScale.Black)
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                startQrCodeScanner()
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async {
                            self.startQrCodeScanner()
                        }
                    } else {
                        self.goBack()
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
        self.view.backgroundColor = .black
        
        self.view.addSubview(qrScannerView)
        self.qrScannerView.addSubview(viewButtons)
        
         NSLayoutConstraint.activate([
           viewButtons.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
           viewButtons.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
         ])
        
        self.qrScannerView.startRunning()
    }
}
