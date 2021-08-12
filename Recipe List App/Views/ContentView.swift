//
//  ContentView.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var model = RecipeModel()
    
    var body: some View {
        
        NavigationView {
            List(model.recipeList) { r in
                
                NavigationLink(
                    destination: RecipeDetailView(recipe: r),
                    label: {
                        // Row Item
                        HStack(spacing: 20){
                            Image(r.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipped()
                                .cornerRadius(10)
                            
                            Text(r.name)
                        }
                    })
                
                
            }
            .navigationTitle("All Recipes")
        }
        
    }
}

struct RecipeListView_Preview: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
