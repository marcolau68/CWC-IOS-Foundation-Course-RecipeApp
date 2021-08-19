//
//  ContentView.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import SwiftUI

struct RecipeListView: View {
        
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top, 30)
                    .font(Font.custom("Avenir Heavy", size: 36))

                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(model.recipeList) { r in
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
                                        
                                        VStack(alignment: .leading) {
                                            Text(r.name)
                                                .bold()
                                                .foregroundColor(.black)
                                                .font(Font.custom("Avenir", size: 16))

                                            Text(r.chainHighlights())
                                                .foregroundColor(.black)
                                                .font(Font.custom("Avenir", size: 16))
                                        }
                                    }
                                })
                        }
                    
                    }
                    .padding(.leading, 10)
                }
                
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct RecipeListView_Preview: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
