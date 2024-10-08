import UIKit


class ImageChooserViewController: UIViewController {
    
    var selectedImageURL: URL?

    let imageURLs: [String: URL] = [
        "image1": URL(string: "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340")!,
        "image2": URL(string: "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg")!,
        "image3": URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCy16nhIbV3pI1qLYHMJKwbH2458oiC9EmA&s")!
    ]

    @IBAction func ChooseBtnOneTapped(_ sender: Any) {
        performSegue(withIdentifier: "image1", sender: self)
    }
    
    @IBAction func ChooseBtnTwoTapped(_ sender: Any) {
        performSegue(withIdentifier: "image2", sender: self)
    }
    
    @IBAction func ChooseBtnTreeTapped(_ sender: Any) {
        performSegue(withIdentifier: "image3", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "image1", let vc =
            segue.destination as? ImageViewController {
                let selectedIdentifier = "image1"
                selectedImageURL = imageURLs[selectedIdentifier]
                vc.imageURL = selectedImageURL
        } else if segue.identifier == "image2", let vc =
            segue.destination as? ImageViewController {
                let selectedIdentifier = "image2"
                selectedImageURL = imageURLs[selectedIdentifier]
                vc.imageURL = selectedImageURL
        } else if segue.identifier == "image3", let vc =
            segue.destination as? ImageViewController {
                let selectedIdentifier = "image3"
                selectedImageURL = imageURLs[selectedIdentifier]
                vc.imageURL = selectedImageURL
        }
    }

}

