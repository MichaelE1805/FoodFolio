//
//  AccountView.swift
//  FoodFolio
//
//  Created by Michael Elasi on 29/7/2026.
//

import SwiftUI
import SwiftData

struct AccountView: View {
    @Query var restaurants: [Restaurant]

    var body: some View {
        Text("Hello, Account!")
    }
}

#Preview {
    AccountView()
}
