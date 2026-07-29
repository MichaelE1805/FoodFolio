//
//  AddRestaurantButton.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import SwiftUI
import SwiftData

struct AddRestaurantButton: View {
    @Environment(\.modelContext) private var context

    var body: some View {
        Button {
            
            let restaurant = Restaurant(
                name: "New Restaurant",
                latitude: -34.0 + Double.random(in: -0.05...0.05),
                longitude: 150.75 + Double.random(in: -0.05...0.05),
                menuItems: []
            )
            context.insert(restaurant)
            //print(restaurant.latitude, "added!")
            
            do {
                let all = try context.fetch(FetchDescriptor<Restaurant>())
                print("Restaurants in context:", all.map { $0.name })
            } catch {
                print("Fetch failed:", error)
            }
        } label: {
            Image(systemName: "plus")
        }
    }
}

