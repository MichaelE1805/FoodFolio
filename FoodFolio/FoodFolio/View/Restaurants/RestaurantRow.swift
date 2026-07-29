//
//  RestaurantRow.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

//import SwiftUI
//import SwiftData
//
//struct RestaurantRow: View {
//    let restaurant: Restaurant
//
//    var progress: Double {
//        let total = restaurant.menuItems.count
//        guard total > 0 else { return 0 }
//        let eaten = restaurant.menuItems.filter { $0.hasEaten }.count
//        return Double(eaten) / Double(total)
//    }
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(restaurant.name)
//                .font(.headline)
//
//            ProgressView(value: progress)
//
//            Text("\(Int(progress * 100))% completed")
//                .font(.caption)
//        }
//    }
//}
