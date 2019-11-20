//
//  Person.swift
//  10-Names-to-Faces
//
//  Created by Audrey Welch on 11/8/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

// When only writing Swift, the Codable protocol is much easier when using UserDefaults

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
