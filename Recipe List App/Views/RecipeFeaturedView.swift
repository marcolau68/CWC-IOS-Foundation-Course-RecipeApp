//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Marco Lau on 14/08/2021.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model: RecipeModel
//    var featuredRecipesList = FeaturedRecipes.listFeaturedRecipes(allRecipe: model.recipeList)
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 0){
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 30)
                .font(.largeTitle)
            
            GeometryReader { geo in
                TabView {
                    ForEach(0..<model.recipeList.count) { index in
                        if model.recipeList[index].featured {
                            VStack {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        
                                    
                                    VStack(spacing: 0) {
                                        Image(model.recipeList[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        
                                        Text(model.recipeList[index].name)
                                            .padding(5)
                                        
                                        
                                    }
                                }
                                .frame(width: geo.size.width*5/6, height: geo.size.height*6/7)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                                
                                
                            }
                        }
                        
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Preparation Time: ")
                    .font(.headline)
                Text("30 minutes")
                Text("Highlights: ")
                    .font(.headline)
                Text("Fast, tasty, simple")
            }
            .padding([.leading, .bottom], 10)
        }
    }
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
