//
//  RestaurantDetailView.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RestaurantDetailView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var restaurant: Restaurant
    
    @State private var showingAddItemAlert = false
    @State private var newItemName = ""
    
    @State private var showingPhotoPicker = false
    @State private var selectedPhoto: PhotosPickerItem? = nil
    @State private var pickedUIImage: UIImage? = nil



    var body: some View {
        ScrollView {
            let columns = [GridItem(.flexible()), GridItem(.flexible())]

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach($restaurant.menuItems) { $item in
                    VStack(spacing: 8) {
                        // Name
                        Text(item.name)
                            .font(.headline)
                            .multilineTextAlignment(.center)

                        // Photo
                        if let data = item.photoData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 100)
                                .cornerRadius(8)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                )
                        }

                        // Counter
                        HStack {
                            Button {
                                if item.timesEaten > 0 { item.timesEaten -= 1 }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }

                            Text("\(item.timesEaten)")
                                .font(.title3)
                                .frame(minWidth: 40)
                                .monospacedDigit()

                            Button {
                                item.timesEaten += 1
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                }
            }
            .padding()
        }



        .navigationTitle(restaurant.name)
        
        VStack(alignment: .leading, spacing: 8) {

            if let address = restaurant.address {
                Label(address, systemImage: "location")
            }

            if let phone = restaurant.phoneNumber {
                Label(phone, systemImage: "phone")
            }

            if let website = restaurant.website,
               let url = URL(string: website) {
                Link(destination: url) {
                    Label("Website", systemImage: "globe")
                }
            }

        }
        .padding()
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Add Item") {
                    newItemName = ""
                    showingAddItemAlert = true
                    //restaurant.menuItems.append(MenuItem(name: "New Item"))
                }

                Button(role: .destructive) {
                    context.delete(restaurant)
                    dismiss()
                } label: {
                    Label("Remove Restaurant", systemImage: "trash")
                }
            }
        }

        .alert("Add Menu Item", isPresented: $showingAddItemAlert) {
            TextField("Item name", text: $newItemName)
            
            Button("Next") {
                let trimmed = newItemName.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                
                // Step 2: Show photo picker after entering name
                showingPhotoPicker = true
            }

            Button("Cancel", role: .cancel) {}
        }
        
        .photosPicker(
            isPresented: $showingPhotoPicker,
            selection: $selectedPhoto,
            matching: .images,
            photoLibrary: .shared()
        )
        
        .onChange(of: selectedPhoto) { newItem in
            guard let newItem else { return }
            
            Task {
                if let data = try? await newItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    pickedUIImage = uiImage
                    
                    // Step 3: Add menu item to restaurant
                    let menuItem = MenuItem(
                        name: newItemName,
                        timesEaten: 0,
                        photoData: uiImage.jpegData(compressionQuality: 0.8)
                    )
                    restaurant.menuItems.append(menuItem)
                    
                    // Save context
                    do {
                        try context.save()
                    } catch {
                        print("Failed to save menu item: \(error)")
                    }
                }
            }
        }
    }
}
