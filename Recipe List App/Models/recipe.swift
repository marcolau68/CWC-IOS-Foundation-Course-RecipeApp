//
//  recipe.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import Foundation

class Recipe: Identifiable, Decodable {
    
    var id: UUID?
    var name: String
    var featured: Bool
    var image: String
    var description: String
    var prepTime: String
    var cookTime: String
    var totalTime: String
    var servings: Int
    var highlights: [String]
    var ingredients: [Ingredient]
    var directions: [String]
    
    func chainHighlights () -> String {
        var allHighlights = ""
        
        for i in 0..<highlights.count {
            if i == highlights.count - 1 {
                allHighlights += highlights[i]
            }
            else {
                allHighlights += highlights[i] + ", "
            }
        }
        
        return allHighlights
    }
    
}






