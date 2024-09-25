import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView1 = UIImageView()
    var imageView2 = UIImageView()
    
    var currentImageIndex = 0
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1.0/5.0
            scrollView.maximumZoomScale = 1.1
            scrollView.delegate = self
            setupImages()
            
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeLeft.direction = .left
            scrollView.addGestureRecognizer(swipeLeft)
            
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
            swipeRight.direction = .right
            scrollView.addGestureRecognizer(swipeRight)
        }
    }
    
    func setupImages() {
        if let url = Bundle.main.url(forResource: "pigeon", withExtension: "jpg"),
               let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                
                imageView1 = UIImageView(image: image)
                imageView1.contentMode = .scaleAspectFit
                imageView1.frame = CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                scrollView.addSubview(imageView1)
            }
        
        if let url = Bundle.main.url(forResource: "pigeon2", withExtension: "jpg"),
               let imageData = try? Data(contentsOf: url),
               let image = UIImage(data: imageData) {
                
                imageView2 = UIImageView(image: image)
                imageView2.contentMode = .scaleAspectFit
                imageView2.frame = CGRect(x: scrollView.bounds.width, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height)
                scrollView.addSubview(imageView2)
            }
            
            scrollView.contentSize = CGSize(width: scrollView.bounds.width * 2, height: scrollView.bounds.height)
            
            let pinchGesture1 = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            imageView1.isUserInteractionEnabled = true
            imageView1.addGestureRecognizer(pinchGesture1)
            
            let pinchGesture2 = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
            imageView2.isUserInteractionEnabled = true
            imageView2.addGestureRecognizer(pinchGesture2)
        }

        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let imageView = gesture.view as? UIImageView else { return }
            imageView.transform = imageView.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1.0
        }

        @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
            let currentOffset = scrollView.contentOffset.x
            let width = scrollView.bounds.width
            if gesture.direction == .left {
                scrollView.setContentOffset(CGPoint(x: currentOffset + width, y: 0), animated: true)
            } else if gesture.direction == .right {
                scrollView.setContentOffset(CGPoint(x: currentOffset - width, y: 0), animated: true)
            }
        }
    
//    var imageURL: URL? {
//        didSet {
//            if view.window != nil {
//                setupImages()
//            }
//        }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if view.window != nil {
//            setupImages()
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = Bundle.main.url(
//                forResource: "pigeon",
//                withExtension: "jpg"
//            )
//        }
//    }
//
//    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
//        let currentOffset = scrollView.contentOffset.x
//        let newOffset: CGFloat
//
//        if gesture.direction == .left {
//            currentImageIndex += 1
//            newOffset = currentOffset + scrollView.bounds.width
//        } else {
//            currentImageIndex -= 1
//            newOffset = currentOffset - scrollView.bounds.width
//        }
//
//        currentImageIndex = max(0, min(currentImageIndex, 1))
//        scrollView.setContentOffset(CGPoint(x: newOffset, y: 0), animated: true)
//    }
//
//
//    private func setupImages() {
//            imageView.image = fetchImage()
//            imageView2.image = fetchImage()
//
//            imageView.contentMode = .scaleToFill
//            imageView2.contentMode = .scaleToFill
//
//            scrollView.addSubview(imageView)
//            scrollView.addSubview(imageView2)
//        }
//
//        override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//
//            let totalWidth = view.bounds.width * 2
//            scrollView.contentSize = CGSize(width: totalWidth, height: view.bounds.height)
//            scrollView.contentOffset = CGPoint(x: 0, y: 0)
//
//            imageView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//            imageView2.frame = CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
//        }
//
//    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
//        return currentImageIndex == 0 ? imageView : imageView2
//    }
//
//
//    private func fetchImage() -> UIImage? {
//        if let url = imageURL {
//            let urlContents = try? Data(contentsOf: url)
//            if let imageData = urlContents {
//                return UIImage(data: imageData)
//            }
//        }
//        return nil
//    }
    
}
