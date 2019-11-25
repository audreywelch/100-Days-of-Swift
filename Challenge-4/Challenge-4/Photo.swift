//
//  Photo.swift
//  Challenge-4
//
//  Created by Audrey Welch on 11/22/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

class Photo: NSObject, Codable {
    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
}
