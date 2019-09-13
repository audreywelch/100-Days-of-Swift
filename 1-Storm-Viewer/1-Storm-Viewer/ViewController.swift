//
//  ViewController.swift
//  1-Storm-Viewer
//
//  Created by Audrey Welch on 9/13/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // MARK: - Properties
    
    var pictures: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set up FileManager
        let fm = FileManager.default
        
        // Resource path of the app's bundle
        let path = Bundle.main.resourcePath!
        
        // Contents of the directory at the path - [String] contains filenames
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                // Store the picture
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
    
    // MARK: - Table View Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Try loading the "Detail" view controller (storyboard ID) & typecasting it to be the DetailViewController
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // Set image
            viewController.selectedImage = pictures[indexPath.row]
            
            // Push onto the navigation controller
            navigationController?.pushViewController(viewController, animated: true)
        }
    }


}

