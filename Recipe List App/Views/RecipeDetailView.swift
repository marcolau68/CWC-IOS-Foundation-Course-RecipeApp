//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Marco Lau on 11/08/2021.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    @State var servingSize = 2
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                
                // MARK: recipe image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: recipe serving size
                VStack(alignment: .leading) {
                    Text("Select serving size: ")
                    
                    Picker("", selection: $servingSize) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                .padding(.leading)
                
                
                // MARK: recipe ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                        .padding(10)
                    
                    ForEach (recipe.ingredients) { ingredient in
                        Text("- " + RecipeModel.getPortion(ingredient: ingredient, recipeServing: recipe.servings, targetServing: servingSize) + ingredient.name)
                            .padding(.bottom, 2)
                    }
                }
                .padding([.leading, .trailing], 10)
                
                Divider()
                
                // MARK: recipe directioins
                VStack (alignment: .leading) {
                    Text("Directions")
                        .font(.headline)
                        .padding(10)
                    
                    ForEach (0..<recipe.directions.count, id: \.self) { index in
                        Text(String(index + 1) + ". " + recipe.directions[index])
                            .padding(.bottom, 2.0)
                    }
                }
                .padding([.leading, .trailing], 10)
            }
            
        }
        .navigationBarTitle(recipe.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Create dummy Recipe so preview works
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipeList[1])
    }
}
