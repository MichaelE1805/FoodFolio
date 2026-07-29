//
//  MenuItem.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import Foundation
import SwiftData
import UIKit

@Model
class MenuItem {
    var name: String
    var timesEaten: Int = 0
    var photoData: Data? = nil   // store image as Data
    
    // Initialiser
    init(name: String, timesEaten: Int = 0, photoData: Data? = nil) {
        self.name = name
        self.timesEaten = timesEaten
        self.photoData = photoData
    }
    
    var photo: UIImage? {
        get {
            guard let data = photoData else { return nil }
            return UIImage(data: data)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.8)
        }
    }
}
