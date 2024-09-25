import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    
    var currentImageIndex = 0
    
    var imageURL1: URL? {
        didSet {
            if view.window != nil {
                setupImages()
            }
        }
    }
    
    var imageURL2: URL? {
        didSet {
            if view.window != nil {
                setupImages()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL1 == nil {
            imageURL1 = Bundle.main.url(
                forResource: "pigeon",
                withExtension: "jpg"
            )
        }
        if imageURL2 == nil {
            imageURL2 = Bundle.main.url(
                forResource: "pigeon2",
                withExtension: "jpg"
            )
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.window != nil {
            setupImages()
        }
    }

    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let imageView = gesture.view as? UIImageView else { return }
        imageView.transform = imageView.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1.0
    }
    
    private func setupUIPinchGestureRecognizers() {
        let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imageView1.isUserInteractionEnabled = true
        imageView1.addGestureRecognizer(pinchGesture1)
        
        let pinchGesture2 = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(pinchGesture2)
    }
    
    private func setupImages() {
        imageView1 = UIImageView(image: fetchImage1())
        imageView1.contentMode = .scaleAspectFill
        imageView1.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.addSubview(imageView1)
        
        imageView2 = UIImageView(image: fetchImage2())
        imageView2.contentMode = .scaleAspectFill
        imageView2.frame = CGRect(x: scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
        scrollView.addSubview(imageView2)
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * 2, height: scrollView.bounds.height)
        
        setupUIPinchGestureRecognizers()
    }
    
    private func fetchImage1() -> UIImage? {
        if let url = imageURL1 {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
    
    private func fetchImage2() -> UIImage? {
        if let url = imageURL2 {
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                return UIImage(data: imageData)
            }
        }
        return nil
    }
}
