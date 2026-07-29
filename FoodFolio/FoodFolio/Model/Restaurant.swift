//
//  Restaurant.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Restaurant: Identifiable {
    
    
    var name: String
    var latitude: Double
    var longitude: Double
    var menuItems: [MenuItem] = []

    // Computed property for MapKit
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // Initializer
    init(name: String, latitude: Double, longitude: Double, menuItems: [MenuItem] = []) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.menuItems = menuItems
    }
}
