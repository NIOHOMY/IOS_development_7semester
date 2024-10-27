import UIKit

class DragAndDropViewController: UIViewController {

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
    
}
