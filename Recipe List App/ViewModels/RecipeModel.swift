//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import Foundation

class RecipeModel: ObservableObject {
    
    @Published var recipeList = [Recipe]()
    
    init() {
        
//        recipeList = DataService().getLocalData() (without static function)
        
        recipeList = DataService.getLocalData()
        
    }
    
    static func getPortion(ingredient: Ingredient, recipeServing: Int, targetServing: Int) -> String {
        var num = ingredient.num ?? 1
        var denom = ingredient.denom ?? 1
        var portion = ""
        var unit: String

        if ingredient.num != nil {
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
            if num > 0 && wholeNum > 0{
                portion += " \(num)/\(denom)"
            }
            else if num > 0 {
                portion += "\(num)/\(denom)"
            }

            portion += unit
            
            return portion
            
            
        }
        else {
            if ingredient.unit != nil {
                return ingredient.unit! + " "
            }
            else {
                return ""
            }
        }
    }

}



//"""
//scenarios
//1. whole number + units
//2. whole number + fraction + units
//3. fraction + units
//4. whole number
//5. whole number + fractions
//6. fractions
//7. units
//"""



