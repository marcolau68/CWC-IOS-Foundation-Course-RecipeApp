//
//  FeaturedRecipes.swift
//  Recipe List App
//
//  Created by Marco Lau on 18/08/2021.
//

import Foundation

struct FeaturedRecipes {
    
    static func listFeaturedRecipes(allRecipe: [Recipe]) -> [Recipe] {
        var featuredRecipe = [Recipe]()
        
        for r in allRecipe {
            if r.featured {
                featuredRecipe.append(r)
            }
        }
        
        return featuredRecipe
    }
    
    
}






