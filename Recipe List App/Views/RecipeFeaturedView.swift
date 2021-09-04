//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Marco Lau on 14/08/2021.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
//    @EnvironmentObject var model: RecipeModel
    @State var detailViewShow = false
    @State var tabIndex = 0
    
    @FetchRequest(sortDescriptors: []) var recipes: FetchedResults<Recipe>
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 0){
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 30)
                .font(Font.custom("Avenir Heavy", size: 36))
            
            GeometryReader { geo in
                TabView(selection: $tabIndex) {
                    ForEach(0..<recipes.count) { index in
                        if recipes[index].featured {
                            Button(action: {
                                detailViewShow = true
                            }, label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        
                                    
                                    VStack(spacing: 0) {
                                        let image = UIImage(data: recipes[index].image ?? Data()) ?? UIImage()
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        
                                        Text(recipes[index].name)
                                            .padding(5)
                                            .font(Font.custom("Avenir", size: 16))
                                        
                                        
                                    }
                                }
                                
                            })
                            .tag(index)
                            .sheet(isPresented: $detailViewShow) {
                                // Show view when true
                                RecipeDetailView(recipe: recipes[index])
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width*5/6, height: geo.size.height*6/7)
                            .cornerRadius(30)
                            .shadow(radius: 10)
                                
                        }
                        
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Preparation Time: ")
                    .font(Font.custom("Avenir Heavy", size: 20))
                Text(recipes[tabIndex].prepTime)
                    .font(Font.custom("Avenir", size: 16))
                Text("Highlights: ")
                    .font(Font.custom("Avenir Heavy", size: 20))
                Text(recipes[tabIndex].chainHighlights())
                    .font(Font.custom("Avenir", size: 16))
            }
            .padding([.leading, .bottom], 10)
        }
        .onAppear(perform: {
            firstFeaturedIndex()
        })
    }
    
    func firstFeaturedIndex() {
        let index = recipes.firstIndex  { (recipe) -> Bool in
            return recipe.featured
        }
        
        tabIndex = index ?? 0
    }
    
}

struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
