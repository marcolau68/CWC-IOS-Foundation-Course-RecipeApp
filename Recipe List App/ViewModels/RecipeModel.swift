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
    
    
    
}







