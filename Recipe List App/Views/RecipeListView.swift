//
//  ContentView.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import SwiftUI

struct RecipeListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var recipes: FetchedResults<Recipe>
    @State private var filterText = ""
    private var filteredRecipes: [Recipe] {
        if filterText == "" {
            return Array(recipes)
        }
        else {
            return recipes.filter { r in
                return r.name.contains(filterText)
            }
        }
        
    }

    var body: some View {
        
        NavigationView {
            VStack(alignment: .leading) {
                Text("All Recipes")
                    .bold()
                    .padding(.leading)
                    .padding(.top, 30)
                    .font(Font.custom("Avenir Heavy", size: 36))
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(5)
                        .shadow(radius: 4)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "magnifyingglass")
                        TextField("Search: ", text: $filterText)
                        
                        Spacer()
                        
                        Button(action: {
                            filterText = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                        })
                    }
                    .padding(.horizontal, 10)
                }
                .frame(height: 48)
                .padding()
                .foregroundColor(.gray)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(filteredRecipes) { r in
                            NavigationLink(
                                destination: RecipeDetailView(recipe: r),
                                label: {
                                    // Row Item
                                    HStack(spacing: 20){
                                        let image = UIImage(data: r.image ?? Data()) ?? UIImage()
                                        Image(uiImage: image)
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
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        
    }

}

struct RecipeListView_Preview: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
