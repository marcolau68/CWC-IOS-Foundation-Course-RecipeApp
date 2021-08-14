//
//  DataService.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        
        // Get a url path to json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        guard pathString != nil else {
            return [Recipe]()
        }
        
        // Create a url object
        let url = URL(fileURLWithPath: pathString!)
        
        // Create a data object
        do {
            let data = try Data(contentsOf: url)
            
            // Decode data with JSONDecoder
            let decoder = JSONDecoder()
            
            do {
                let recipeData = try decoder.decode([Recipe].self, from: data)
                
                // Give unique IDs
                for r in recipeData {
                    r.id = UUID()
                    // Give unique IDs to ingredients
                    
                    for i in r.ingredients {
                        i.id = UUID()
                    }
                }
                
                // Return the recipes
                return recipeData
                
            }
            catch {
                print(error)
            }
            
        }
        catch {
            print(error)
        }
        
       
        return [Recipe]()
    }
    
}









