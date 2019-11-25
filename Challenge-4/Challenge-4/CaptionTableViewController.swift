//
//  ViewController.swift
//  Challenge-4
//
//  Created by Audrey Welch on 11/22/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class CaptionTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photos: [Photo] = []
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = photos[indexPath.row].caption
        
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Extract the image from the dictionary that is passed as a parameter
        guard let image = info[.originalImage] as? UIImage else { return }
        
        // Generate a unique filename for it
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // Convert it to a JPEG, then write that JPEG to disk
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let ac = UIAlertController(title: "Give your photo a caption", message: nil, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let newCaption = ac?.textFields?[0].text else { return }
            
            // Create a photo object, add it to our array, and reload the table view
            let photo = Photo(caption: newCaption, image: imageName)
            self?.photos.append(photo)
            self?.tableView.reloadData()
        })
        
        // Dismiss the view controller
        dismiss(animated: true)
        
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func save() {
        
        // Use the JSONEncoder class to convert photos array into a Data object
        // Save the Data object to UserDefaults
        
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(photos) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "photos")
        } else {
            print("Failed to save photos.")
        }
    }


}

