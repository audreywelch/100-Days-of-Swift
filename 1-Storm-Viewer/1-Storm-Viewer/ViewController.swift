//
//  ViewController.swift
//  1-Storm-Viewer
//
//  Created by Audrey Welch on 9/13/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var pictures: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
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


}

