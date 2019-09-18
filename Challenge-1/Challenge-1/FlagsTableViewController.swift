
import UIKit

class FlagsTableViewController: UITableViewController {

    var countries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load images from disk
//        let fm = FileManager.default
//        let path = Bundle.main.resourcePath!
//        let items = try! fm.contentsOfDirectory(atPath: path)

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "flagCell", for: indexPath)

        // If country has only two letters (US/UK), uppercase both letters
        if countries[indexPath.row].count <= 2 {
            cell.textLabel?.text = countries[indexPath.row].uppercased()
            
        // If country has more than two letters, capitalize the first letter
        } else {
            cell.textLabel?.text = countries[indexPath.row].capitalized
        }
        
        return cell
    }
 


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        guard let destinationVC = segue.destination as? FlagDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        // Pass the selected object to the new view controller.
        destinationVC.selectedFlag = countries[indexPath.row]
        
    }

}
