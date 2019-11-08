//
//  ViewController.swift
//  10-Names-to-Faces
//
//  Created by Audrey Welch on 11/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }
    
    @objc func addNewPerson() {
        
        let picker = UIImagePickerController()
        
        // Allows user to crop the picture they select
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.reuseIdentifier, for: indexPath) as? PersonCollectionViewCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        return cell
    }
    
    // Returns when user selected an image and it's being returned to you
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Extract the image from the dictionary that is passed as a parameter
        guard let image = info[.editedImage] as? UIImage else { return }
        
        // Generate a unique filename for it
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        // Convert it to a JPEG, then write that JPEG to disk
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        // Dismiss the view controller
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }


}

