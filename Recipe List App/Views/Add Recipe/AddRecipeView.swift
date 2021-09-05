//
//  AddRecipeView.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//

import SwiftUI

struct AddRecipeView: View {
    
    @Binding var tabIndex: Int
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name = ""
    @State private var summary = ""
    @State private var prepTime = ""
    @State private var cookTime = ""
    @State private var totalTime = ""
    @State private var servings = ""
    
    @State private var highlights = [String]()
    @State private var directions = [String]()
    
    @State private var ingredients = [IngredientJSON]()
    
    @State private var openImagePicker = false
    @State private var imageSource = UIImagePickerController.SourceType.photoLibrary
    
    @State private var recipeImage: UIImage?

    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    clear()
                }, label: {
                    Text("Clear")
                })
                
                Spacer()
                
                Button(action: {
                    // Add recipe
                    add()
                    
                    // Clear sheet
                    clear()
                    
                    // Switch to list view
                    tabIndex = 1
                    
                }, label: {
                    Text("Add")
                })
            }
            .padding(.bottom)
            
            if recipeImage == nil {
                Image("noImageAvailable")
                    .resizable()
                    .scaledToFit()
            }
            else {
                Image(uiImage: recipeImage!)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
            
            HStack {
                Spacer()
                
                Button("Photo Library") {
                    openImagePicker = true
                    imageSource = UIImagePickerController.SourceType.photoLibrary
                }
                .sheet(isPresented: $openImagePicker) {
                    ImagePicker(recipeImage: $recipeImage, source: imageSource)
                }
                
                Spacer()
                
                Button("Camera") {
                    openImagePicker = true
                    imageSource = UIImagePickerController.SourceType.camera
                }
                .sheet(isPresented: $openImagePicker) {
                    ImagePicker(recipeImage: $recipeImage, source: imageSource)
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
        
        recipeImage = nil
    }
    
    func add() {
        let recipe = Recipe(context: viewContext)
        
        recipe.id = UUID()
        recipe.name = name
        recipe.summary = summary
        recipe.prepTime = prepTime
        recipe.cookTime = cookTime
        recipe.totalTime = totalTime
        recipe.servings = Int(servings) ?? 1
        recipe.highlights = highlights
        recipe.directions = directions
        recipe.image = recipeImage?.pngData()
                
        for i in ingredients {
            let ingredient = Ingredient(context: viewContext)
            
            ingredient.name = i.name
            ingredient.id = UUID()
            ingredient.num = i.num ?? 1
            ingredient.denom = i.denom ?? 1
            ingredient.unit = i.unit
            
            recipe.addToIngredients(ingredient)
        }
        
        do {
            try viewContext.save()
            
        }
        catch {
            // Can't save recipe
        }
        
        
        
    }
}
    
