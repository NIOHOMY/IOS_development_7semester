import UIKit

class DragAndDropViewController: UIViewController, UIDropInteractionDelegate {
    
    var imageFetcher: ImageFetcher!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBOutlet weak var dropZone: UIView! {
        didSet {
            dropZone.addInteraction(UIDropInteraction(delegate: self))
        }
    }
    
    @IBOutlet weak var imageCardView: ImageViewCardController!
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self) || session.canLoadObjects(ofClass: NSURL.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation:  .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                self.imageCardView.image = image
            }
        }
        session.loadObjects(ofClass: NSURL.self) { nsurls in
            if let url = nsurls.first as? URL {
                self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: UIImage.self) { images in
            if let image = images.first as? UIImage {
                self.imageFetcher.backup = image
            }
        }
    }
}
