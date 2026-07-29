//
//  RestaurantListView.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Query var restaurants: [Restaurant]

    var body: some View {
        NavigationStack {
            List {
                ForEach(restaurants) { restaurant in
                    NavigationLink {
                        RestaurantDetailView(restaurant: restaurant)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            // Restaurant Name
                            Text(restaurant.name)
                                .font(.headline)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Restaurants")
            .toolbar {
                AddRestaurantButton()
            }
        }
    }
}

#Preview {
    RestaurantListView()
        .modelContainer(for: [Restaurant.self, MenuItem.self])
}

