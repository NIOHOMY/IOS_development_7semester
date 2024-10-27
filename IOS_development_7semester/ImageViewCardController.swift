import UIKit

class ImageViewCardController: UIView {

    var image: UIImage! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        image?.draw(in: bounds)
    }

}
