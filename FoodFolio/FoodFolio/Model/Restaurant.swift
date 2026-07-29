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
    
    // New information
    var address: String?
    var phoneNumber: String?
    var website: String?
    var dateAdded: Date
    var notes: String?
    
    @Relationship(deleteRule: .cascade)
    var menuItems: [MenuItem] = []

    // Computed property for MapKit
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(
        name: String,
        latitude: Double,
        longitude: Double,
        address: String? = nil,
        phoneNumber: String? = nil,
        website: String? = nil,
        dateAdded: Date = Date(),
        notes: String? = nil,
        menuItems: [MenuItem] = []
    ) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.phoneNumber = phoneNumber
        self.website = website
        self.dateAdded = dateAdded
        self.notes = notes
        self.menuItems = menuItems
    }
}
