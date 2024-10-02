import UIKit
import Alamofire

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1.0/5.0
            scrollView.maximumZoomScale = 1.1
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    private var img: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    var imageURL: URL? {
        didSet {
            img = nil
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.window != nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = URL(string: "https://media.istockphoto.com/id/506470828/photo/taking-picture.jpg?s=170667a&w=0&k=20&c=MWyWduuMfAXmqG7SBDco0Q-Gl1tEHS7_DupqyqmvEKE=")
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func fetchImage() {
        guard let imageUrl = imageURL else { return }
            
        AF.request(imageUrl).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.img = image
                }
                
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        if let sourceVC = segue.source as? ImageChooserViewController {
            if let selectedURL = sourceVC.selectedImageURL {
                print("URL: \(selectedURL)")
                imageURL = selectedURL
            }
        }
    }

    
}
