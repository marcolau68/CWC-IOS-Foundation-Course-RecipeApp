//
//  AddRecipeView.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//

import SwiftUI

struct AddRecipeView: View {
    
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    @State private var servings = ""
    
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    @State private var ingredients = [IngredientJSON]()

    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    clear()
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Button(action: {
                    // Add recipe
                    add()
                    
                    // Clear sheet
                    clear()
                    
                }, label: {
                    Text("Add")
                })
            }
            .padding(.bottom)
            
            Image("noImageAvailable")
                .resizable()
                .scaledToFit()
            
            HStack {
                Spacer()
                
                Button("Photo Library") {
                    
                }
                
                Spacer()
                
                Button("Camera") {
                    
                }
                
                Spacer()
            }
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    // String data
                    AddRecipeStringData(name: $name, summary: $summary, prepTime: $prepTime, cookTime: $cookTime, totalTime: $totalTime, servings: $servings)
                    
                    // List data
                    AddListData(list: $highlights, title: "Highlights: ", example: "Easy to make")
                    
                    AddListData(list: $directions, title: "Directions: ", example: "Season chicken with spices")
                    
                    // Ingredient data
                    AddIngredientData(ingredients: $ingredients)
                    
                }
            }
        }
        .padding()
    }
    
    func clear() {
        name = ""
        summary = ""
        prepTime = ""
        cookTime = ""
        totalTime = ""
        servings = ""
        
        highlights = [String]()
        directions = [String]()
        
        ingredients = [IngredientJSON]()
    }
    
    func add() {
        
    }
}
    
