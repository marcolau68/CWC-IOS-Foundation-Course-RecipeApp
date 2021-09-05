//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import Foundation
import UIKit

class RecipeModel: ObservableObject {
    @Published var recipeList = [Recipe]()
    
    let managedObjectContext = PersistenceController.shared.container.viewContext
    
    init() {
        
//        recipeList = DataService().getLocalData() (without static function)
        
//        recipeList = DataService.getLocalData()
        
        // Check if we have prexisting data
        checkLoadedData()
    }
    
    func checkLoadedData() {
        // Check local storage for data
        let status = UserDefaults.standard.bool(forKey: Constants.isDataPreloaded)
        
        // If none, parse JSON file and preload into Core Data
        if status == false {
            // Preload data
            preloadLocalData()
        }
        else {
            
        }
    }
    
    func preloadLocalData() {
        // Parse local JSON file
        let localRecipeList = DataService.getLocalData()
        
        // Create core data objects
        for r in localRecipeList {
            let recipe = Recipe(context: managedObjectContext)
            
            recipe.cookTime = r.cookTime
            recipe.directions = r.directions
            recipe.featured = r.featured
            recipe.highlights = r.highlights
            recipe.image = UIImage(named: r.image)?.jpegData(compressionQuality: 1.0)
            recipe.id = UUID()
            recipe.name = r.name
            recipe.prepTime = r.prepTime
            recipe.servings = r.servings
            recipe.summary = r.description
            recipe.totalTime = r.totalTime
            
            for i in r.ingredients {
                let ingredient = Ingredient(context: managedObjectContext)
                
                ingredient.id = UUID()
                ingredient.denom = i.denom ?? 1
                ingredient.name = i.name
                ingredient.num = i.num ?? 1
                ingredient.unit = i.unit
                
                recipe.addToIngredients(ingredient)
            }
            
        }
        
        // Save into core data
        do {
            try managedObjectContext.save()
            
        }
        catch {
            
        }
        
        // Set local storage flag
        UserDefaults.standard.setValue(true, forKey: Constants.isDataPreloaded)
    }
    
    static func getPortion(ingredient: Ingredient, recipeServing: Int, targetServing: Int) -> String {
        var num = ingredient.num
        var denom = ingredient.denom
        var portion = ""
        var unit: String

        // Get single serving size by multiplying recipe serving size by denominator
        denom *= recipeServing

        // Get target portion by multiplying target serving size by numerator
        num *= targetServing

        // Simplify fraction using largest factor
        var smallerNum: Int
        var lcd = 1

        if num > denom {
            smallerNum = denom
        }
        else {
            smallerNum = num
        }

        if num % denom == 0 {
            num /= denom
            denom = 1
        }
        else if denom % num == 0 {
            denom /= num
            num = 1
        }
        else {
            for i in 2..<smallerNum {
                if (num % i == 0) && (denom % i == 0) {
                    lcd = i
                }
            }

            num /= lcd
            denom /= lcd
        }

        // Get the whole number
        var wholeNum = 0
        
        if num >= denom {
            wholeNum = num / denom
            num = num % denom
            
            portion += String(wholeNum)
        }
        
        // Get unit
        if ingredient.unit != nil && (num != 0 || wholeNum != 0) {
            unit = " " + ingredient.unit!
        }
        else if ingredient.unit != nil {
            unit = ingredient.unit!
        }
        else {
            unit = ""
        }
        
        if unit != "" && ((wholeNum > 0 && num > 0) || (wholeNum  > 1)) {
            if unit.suffix(2) == "ch" {
                unit += "es "
            }
            else if unit.suffix(1) == "f" {
                unit = String(unit.dropLast())
                unit += "ves "
            }
            else {
                unit += "s "
            }
        }
        else {
            unit += " "
        }
    
        // Get remainder in fraction
        if num > 0 && wholeNum > 0 {
            portion += " \(num)/\(denom)"
        }
        else if num > 0 {
            portion += "\(num)/\(denom)"
        }

        portion += unit
        
        return portion
    }
}



/*
scenarios
1. whole number + units
2. whole number + fraction + units
3. fraction + units
4. whole number
5. whole number + fractions
6. fractions
7. units
*/



