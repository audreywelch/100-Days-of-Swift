//
//  DetailViewController.swift
//  1-Storm-Viewer
//
//  Created by Audrey Welch on 9/13/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Picture \(selectedPictureNumber) of \(totalPictures)"
        
        // Create bar button item and trigger shareTapped() method when tapped
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Large titles only in the first view controller
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Tap to see a picture full size / hide the navigation bar
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Only hide the navigation bar on tapping in the DetailView
        navigationController?.hidesBarsOnTap = false
    }
    
    // Allow sending photos via AirDrop, Twitter, etc.
    @objc func shareTapped() {
        
        // In case the image view does not have an image inside, convert to JPEG data
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        // Create a UIActivityViewController (iOS method of sharing content w/ other apps)
        // Pass in the array of items you want to share and an array of any of my app's services to make sure are on the list
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        
        // Tell iOS where the activity view controller should appear from, anchor it from the right bar button item
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
