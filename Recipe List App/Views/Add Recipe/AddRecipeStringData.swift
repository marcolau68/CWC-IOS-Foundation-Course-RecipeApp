//
//  AddRecipeStringData.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//

import SwiftUI

struct AddRecipeStringData: View {
    
    @Binding var name: String
    @Binding var summary: String
    @Binding var prepTime: String
    @Binding var cookTime: String
    @Binding var totalTime: String
    @Binding var servings: String
    
    var body: some View {
        Group {
            HStack {
                Text("Name: ")
                    .bold()
                TextField("Chicken Alfredo", text: $name)
            }
            
            HStack {
                Text("Summary: ")
                    .bold()
                TextField("A delicious Sunday Roast", text: $summary)
            }
            
            HStack {
                Text("Prep Time: ")
                    .bold()
                TextField("30 minutes", text: $prepTime)
            }
            
            HStack {
                Text("Cook Time: ")
                    .bold()
                TextField("15 minutes", text: $cookTime)
            }
            
            HStack {
                Text("Total Time: ")
                    .bold()
                TextField("45 minutes", text: $totalTime)
            }
            
            HStack {
                Text("Servings: ")
                    .bold()
                TextField("4", text: $servings)
            }
        }
    }
}

