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
            if view.window != nil {
                fetchImage()
            }
        }
    }
    
    var imageDescription: String?
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if view.window != nil {
            fetchImage()
            loadDescription()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = URL(string: "https://media.istockphoto.com/id/506470828/photo/taking-picture.jpg?s=170667a&w=0&k=20&c=MWyWduuMfAXmqG7SBDco0Q-Gl1tEHS7_DupqyqmvEKE=")
        }
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        if let viewControllers = navigationController?.viewControllers {
            if viewControllers.count >= 3 {
                navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            } else {
                navigationController?.popViewController(animated: true)
            }
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

    func loadDescription() {
        guard let curimageDescription = imageDescription else { return }
        print("Loading image description: \(curimageDescription)")
        descriptionLabel.text = curimageDescription
    }
    

    
}
