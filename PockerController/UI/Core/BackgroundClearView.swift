import Foundation
import SwiftUI

struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = UIColor(GrayScale.Black)
            view.superview?.superview?.layer.removeAllAnimations()
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
