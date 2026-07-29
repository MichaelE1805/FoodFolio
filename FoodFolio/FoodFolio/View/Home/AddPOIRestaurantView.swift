//
//  AddPOIRestaurantView.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import SwiftUI
import SwiftData
import MapKit
import Contacts

struct AddPOIRestaurantView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    let mapItem: MKMapItem
    
    @State private var existingRestaurant: Restaurant?
    
    @Binding var selectedRestaurant: Restaurant?
    @State private var navigateToRestaurant = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                // Name
                Text(mapItem.name ?? "Restaurant")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Divider()
                
                
                // Address
                if let postalAddress = mapItem.placemark.postalAddress {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Address")
                            .font(.headline)
                        
                        Text("\(postalAddress.street), \(postalAddress.city), \(postalAddress.state) \(postalAddress.postalCode)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                // Phone Number
                if let phone = mapItem.phoneNumber {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Phone")
                            .font(.headline)
                        
                        Text(phone)
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                // Website
                if let url = mapItem.url {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Website")
                            .font(.headline)
                        
                        Link(destination: url) {
                            Text(url.absoluteString)
                                .foregroundStyle(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                
                Divider()
                
                
                // Button changes depending if restaurant exists
                if existingRestaurant != nil {
                    Button {
                        selectedRestaurant = existingRestaurant
                        dismiss()
                    } label: {
                        Text("Open Restaurant")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                } else {
                    
                    Button {
                        addRestaurant()
                    } label: {
                        Text("Add to My Restaurants")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationDestination(isPresented: $navigateToRestaurant) {
            if let restaurant = existingRestaurant {
                RestaurantDetailView(restaurant: restaurant)
            }
        }
        .onAppear {
            checkIfRestaurantExists()
        }
    }
    
    
    // Checks if this restaurant is already saved
    private func checkIfRestaurantExists() {
        let name = mapItem.name ?? "Restaurant"
        let latitude = mapItem.placemark.coordinate.latitude
        let longitude = mapItem.placemark.coordinate.longitude
        
        do {
            let restaurants = try context.fetch(FetchDescriptor<Restaurant>())
            
            existingRestaurant = restaurants.first {
                $0.name == name &&
                abs($0.latitude - latitude) < 0.00001 &&
                abs($0.longitude - longitude) < 0.00001
            }
            
        } catch {
            print("Failed to fetch restaurants: \(error)")
        }
    }
    
    
    // Saves new restaurant
    private func addRestaurant() {
        let restaurant = Restaurant(
            name: mapItem.name ?? "Restaurant",
            latitude: mapItem.placemark.coordinate.latitude,
            longitude: mapItem.placemark.coordinate.longitude,
            menuItems: []
        )
        
        context.insert(restaurant)
        
        do {
            try context.save()
            existingRestaurant = restaurant
            
        } catch {
            print("Failed to save restaurant: \(error)")
        }
    }
}


#Preview {
    HomeView()
        .modelContainer(for: [Restaurant.self, MenuItem.self])
}
