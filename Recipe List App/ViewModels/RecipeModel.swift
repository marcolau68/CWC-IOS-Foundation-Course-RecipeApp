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
        if ingredient.num != nil {
            // Get single serving size by multiplying recipe serving size by denominator
            var denom: Int

            if ingredient.denom != nil {
                denom = ingredient.denom! * recipeServing
            }
            else {
                denom = recipeServing
            }

            // Get target portion by multiplying target serving size by numerator
            var num: Int = ingredient.num! * targetServing

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
            // Get remainder in fraction
            var wholeNum = 0
            
            if num > denom {
                wholeNum = num / denom
                num -= wholeNum * denom
            }

            var unit = ""

            if ingredient.unit != nil {
                if wholeNum > 0 {
                    unit = ingredient.unit! + "s "
                }
                else {
                    unit = ingredient.unit! + " "
                }

            }

            if num == 0 {
                return "\(wholeNum) \(unit)"
            }
            else {
                if wholeNum > 0 {
                    return "\(wholeNum) \(num)/\(denom) \(unit)"
                }
                else {
                    return "\(num)/\(denom) \(unit)"
                }
            }

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







