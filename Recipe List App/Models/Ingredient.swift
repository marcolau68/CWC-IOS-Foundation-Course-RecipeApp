//
//  Ingredient.swift
//  Recipe List App
//
//  Created by Marco Lau on 14/08/2021.
//

import Foundation

class IngredientJSON: Identifiable, Decodable {
    var id: UUID?
    var name: String
    var num: Int?
    var denom: Int?
    var unit: String?
}




