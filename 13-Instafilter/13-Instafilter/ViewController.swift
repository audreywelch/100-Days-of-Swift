//
//  ViewController.swift
//  13-Instafilter
//
//  Created by Audrey Welch on 1/21/20.
//  Copyright © 2020 Audrey Welch. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var intensity: UISlider!
    
    var currentImage: UIImage!
    
    // Core Image component that handles rendering
    var context: CIContext!
    
    // Stores whatever filter the user has activated
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add button to the navigation bar to allow users to import a photo from their library
        title = "InstaFilter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    @objc func importPicture() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }

    @IBAction func changeFilter(_ sender: Any) {
        
    }
    
    @IBAction func save(_ sender: Any) {
        
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    func applyProcessing() {
        
        // Safely read the output image from our current filter
        guard let image = currentFilter.outputImage else { return }
        
        // Use the value of our intensity slider to set the kCIInputIntensityKey value
        // of current Core Image filter
        currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)
        
        // Create a new data type called CGImage from the output image of the current filter,
        // filtering all of the image (the entire extent)
        // Returns an optional CGImage
        if let cgimg = context.createCGImage(image, from: image.extent) {
            
            // Create a new UIImage from the CGImage
            let processedImage = UIImage(cgImage: cgimg)
            
            // Assign that UIImage to the image view
            imageView.image = processedImage
        }
        
    }
    
}

