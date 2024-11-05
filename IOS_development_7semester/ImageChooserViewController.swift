import UIKit


class ImageChooserViewController: UITableViewController {
    
    var selectedImageURL: URL?
    var selectedImageDescription: String?

    let imageItems: [ImageItem] = [
        ImageItem(title: "Image 1", imageURL: URL(string: "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340")!, description: "This is the first image description."),
        ImageItem(title: "Image 2", imageURL: URL(string: "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg")!, description: "This is the second image description."),
        ImageItem(title: "Image 3", imageURL: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmCy16nhIbV3pI1qLYHMJKwbH2458oiC9EmA&s")!, description: "This is the third image description.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageItems.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let imageItem = imageItems[indexPath.row]
        cell.textLabel?.text = imageItem.title
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageItem = imageItems[indexPath.row]
        selectedImageURL = imageItem.imageURL
        selectedImageDescription = imageItem.description
        
        performSegue(withIdentifier: "showImage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showImage" {
            if let vc = segue.destination as? ImageViewController {
                vc.imageURL = selectedImageURL
                vc.imageDescription = selectedImageDescription
            }
        }
    }

}

