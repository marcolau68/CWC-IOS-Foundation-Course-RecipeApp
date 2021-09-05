//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Marco Lau on 13/08/2021.
//

import SwiftUI

struct RecipeTabView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            RecipeFeaturedView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Featured")
                }
                .tag(Constants.featuredTab)
            
            RecipeListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
                .tag(Constants.listTab)
            
            AddRecipeView(tabIndex: $tabIndex)
                .tabItem {
                    Image(systemName: "plus.circle")
                    Text("Add")
                }
                .tag(Constants.addTab)
        }
        .environmentObject(RecipeModel())
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
