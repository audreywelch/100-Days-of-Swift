//
//  Photo.swift
//  Challenge-4
//
//  Created by Audrey Welch on 11/22/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
