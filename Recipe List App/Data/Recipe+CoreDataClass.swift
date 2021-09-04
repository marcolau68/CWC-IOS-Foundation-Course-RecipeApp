//
//  Recipe+CoreDataClass.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//
//

import Foundation
import CoreData

@objc(Recipe)
public class Recipe: NSManagedObject {
    
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
