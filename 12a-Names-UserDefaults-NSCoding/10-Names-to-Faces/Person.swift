//
//  Person.swift
//  10-Names-to-Faces
//
//  Created by Audrey Welch on 11/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

// NSCoding is a great way to read and write data when using UserDefaults, and it's
// th emost common option when you must write Swift code that lives alongside Obj-C code

class Person: NSObject, NSCoding {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    // Used when loading objects of this class
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    // Used when saving
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
    

    
//    required init(coder aDecoder: NSCoder) {
//        name = aDecoder.decodedObject(forKey: "name") as? String ?? ""
//        image = aDecoder.decodedObject(forKey: "image") as? String ?? ""
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(image, forKey: "image")
//    }
}
