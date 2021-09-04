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
                let image = UIImage(data: recipe.image ?? Data()) ?? UIImage()
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                
                // MARK: recipe title
                Text(recipe.name)
                    .bold()
                    .padding()
                    .font(Font.custom("Avenir Heavy", size: 36))

                // MARK: recipe serving size
                VStack(alignment: .leading) {
                    Text("Select serving size: ")
                        .font(Font.custom("Avenir", size: 16))
                    
                    Picker("", selection: $servingSize) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .font(Font.custom("Avenir", size: 16))
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 200)
                }
                .padding(.leading)
                
                
                // MARK: recipe ingredients
                VStack (alignment: .leading) {
                    Text("Ingredients")
                        .font(Font.custom("Avenir Heavy", size: 20))
                        .padding(10)
                    
                    ForEach (recipe.ingredients.allObjects as! [Ingredient]) { ingredient in
                        Text("- " + RecipeModel.getPortion(ingredient: ingredient, recipeServing: recipe.servings, targetServing: servingSize) + ingredient.name.lowercased())
                            .padding(.bottom, 2)
                            .font(Font.custom("Avenir", size: 16))
                    }
                }
                .padding([.leading, .trailing], 10)
                
                Divider()
                
                // MARK: recipe directions
                VStack (alignment: .leading) {
                    Text("Directions")
                        .font(Font.custom("Avenir Heavy", size: 20))
                        .padding(10)
                    
                    ForEach (0..<recipe.directions.count, id: \.self) { index in
                        Text(String(index + 1) + ". " + recipe.directions[index])
                            .padding(.bottom, 2.0)
                            .font(Font.custom("Avenir", size: 16))
                    }
                }
                .padding([.leading, .trailing], 10)
            }
            
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Create dummy Recipe so preview works
        
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipeList[1])
    }
}
