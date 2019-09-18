
import UIKit

class FlagDetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    
    var selectedFlag: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set title
        if selectedFlag.count <= 2 {
            self.title = selectedFlag.uppercased()
        } else {
            self.title = selectedFlag.capitalized
        }
        
        // Create bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Load image view
        self.flagImageView.image = UIImage(named: selectedFlag)
        self.flagImageView.layer.borderWidth = 1
        self.flagImageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @objc func shareTapped() {
        
        // In case the image view does not have an image inside, convert to JPEG data
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        // Create a UIActivityViewController
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }

}
