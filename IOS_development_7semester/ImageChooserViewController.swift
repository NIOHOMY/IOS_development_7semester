import UIKit


class ImageChooserViewController: UIViewController {
    
    var selectedImageURL: URL?

    let imageURLs: [String: URL] = [
        "image1": URL(string: "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340")!,
        "image2": URL(string: "https://example.com/image2.jpg")!
    ]

    @IBAction func chooseImageButtonTapped(_ sender: UIButton) {
        let selectedIdentifier = "image1"
        selectedImageURL = imageURLs[selectedIdentifier]
        
        performSegue(withIdentifier: "unwindToImageViewController", sender: self)
    }

}

