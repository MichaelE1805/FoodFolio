//
//  IdentifiableMapItem.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//


import SwiftUI
import MapKit

struct IdentifiableMapItem: Identifiable {
    let id = UUID()
    let item: MKMapItem
}
