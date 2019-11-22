//
//  ViewController.swift
//  Challenge-4
//
//  Created by Audrey Welch on 11/22/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class CaptionTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Item to add an image
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
        
    }
    
    @objc func addNewImage() {
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }


}

