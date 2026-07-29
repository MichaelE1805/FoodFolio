//
//  FoodFolioApp.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

//import SwiftUI
//
//@main
//struct FoodFolioApp: App {
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
//}

import SwiftUI
import SwiftData

@main
struct FoodFolioApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Restaurant.self, MenuItem.self])
    }
}
