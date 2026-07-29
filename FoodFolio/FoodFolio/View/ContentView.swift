//
//  ContentView.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var restaurants: [Restaurant]

    var body: some View {
        
        TabView {
            AccountView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Account")
                }
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            RestaurantListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
        }
        .padding(.bottom, -50.0)
    }
}


#Preview {
    ContentView()
        .modelContainer(for: [Restaurant.self, MenuItem.self])
}
