//
//  DetailViewController.swift
//  Challenge-4
//
//  Created by Audrey Welch on 11/25/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoCaptionLabel: UILabel!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        
    }
    
    func updateViews() {
        // Check that the view is loaded
        guard isViewLoaded else { return }
        
        // Ensure we have a photo to present
        if let photo = photo {
            
            // Populate the label and image view
            let path = CaptionTableViewController.getDocumentsDirectory().appendingPathComponent(photo.image)
            photoImageView.image = UIImage(contentsOfFile: path.path)
            
            photoCaptionLabel.text = photo.caption
            
        }
    }
    
}
