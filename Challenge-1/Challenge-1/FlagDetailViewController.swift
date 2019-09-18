
import UIKit

class FlagDetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    
    var selectedFlag: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if selectedFlag.count <= 2 {
            self.title = selectedFlag.uppercased()
        } else {
            self.title = selectedFlag.capitalized
        }
        
        self.flagImageView.image = UIImage(named: selectedFlag)
        self.flagImageView.layer.borderWidth = 1
        self.flagImageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }

}
