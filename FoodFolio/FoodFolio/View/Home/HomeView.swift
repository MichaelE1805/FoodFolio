//
//  HomeView.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//


import SwiftUI
import SwiftData
import MapKit

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query var restaurants: [Restaurant]
    
    @State private var cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: -34.023987, longitude: 150.754667),
                latitudinalMeters: 1300, longitudinalMeters: 1300))

    // The MKMapItem obtained from a selected feature
    
    @State private var selectedFeature: MapFeature?   // POI tapped
    @State private var selectedMapItem: IdentifiableMapItem?
    
    @State private var selectedRestaurant: Restaurant?

    
    let locationManager = CLLocationManager()
    
    var body: some View {
        NavigationStack {
            Map(
                position: $cameraPosition,
                selection: $selectedFeature
            )
            .mapStyle(.standard(pointsOfInterest: [.restaurant, .cafe, .bakery]))
            .mapFeatureSelectionDisabled { feature in
                feature.kind != .pointOfInterest
            }
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            .onChange(of: selectedFeature) { _, feature in
                guard let feature else { return }
                Task {
                    do {
                        let request = MKMapItemRequest(feature: feature)
                        let mapItem = try await request.mapItem
                        selectedMapItem = IdentifiableMapItem(item: mapItem)
                    } catch {
                        print("Failed to get MKMapItem: \(error)")
                    }
                }
            }
            .sheet(item: $selectedMapItem) { wrapped in
                AddPOIRestaurantView(
                    mapItem: wrapped.item,
                    selectedRestaurant: $selectedRestaurant
                )
            }
            .navigationDestination(item: $selectedRestaurant) { restaurant in
                RestaurantDetailView(restaurant: restaurant)
            }
            .mapControls {
                MapUserLocationButton()
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [Restaurant.self, MenuItem.self])
}
