//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Marco Lau on 13/08/2021.
//

import SwiftUI

struct RecipeTabView: View {
    
    var body: some View {
        TabView {
            RecipeFeaturedView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
            
            RecipeListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            
            AddRecipeView()
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add")
                }
        }
        .environmentObject(RecipeModel())
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
