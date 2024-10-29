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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageCardView2: ImageViewCardController!
    @IBOutlet weak var label2: UILabel!
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return (session.canLoadObjects(ofClass: UIImage.self) && session.canLoadObjects(ofClass: NSURL.self)) ||
            session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation:  .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        imageFetcher = ImageFetcher() { (url, image) in
            DispatchQueue.main.async {
                if self.imageCardView.image == nil {
                    self.imageCardView.image = image
                } else if self.imageCardView2.image == nil {
                    self.imageCardView2.image = image
                }
            }
        }
        
        session.loadObjects(ofClass: NSAttributedString.self) { attributedStrings in
            if let attributedString = attributedStrings.first as? NSAttributedString {
                let text = attributedString.string
                DispatchQueue.main.async {
                    if self.label.text == nil || self.label.text == "" {
                        self.label.text = text
                    } else if self.label2.text == nil || self.label2.text == "" {
                        self.label2.text = text
                    }
                }
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
