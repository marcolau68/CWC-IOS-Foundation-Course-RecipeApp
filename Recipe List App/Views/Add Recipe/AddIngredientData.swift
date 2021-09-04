//
//  AddIngredientData.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//

import SwiftUI

struct AddIngredientData: View {
    
    @Binding var ingredients: [IngredientJSON]
    @State var name = ""
    @State var num = "1"
    @State var denom = "1"
    @State var unit = ""
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredient: ")
                .bold()
                .padding(.top, 5)
            
            HStack(spacing: 5) {
                TextField("Sugar", text: $name)
                TextField("1", text: $num)
                    .frame(width: 20)
                Text(" / ")
                TextField("2", text: $denom)
                    .frame(width: 20)
                TextField("tablespoon", text: $unit)
                
                Spacer()
                
                Button(action: {
                    
                    let correctName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    let correctNum = num.trimmingCharacters(in: .whitespacesAndNewlines)
                    let correctDenom = denom.trimmingCharacters(in: .whitespacesAndNewlines)
                    let correctUnit = unit.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if (correctName != "") && (correctNum != "") && (correctDenom != "") && (correctUnit != "") {
                        let i = IngredientJSON()
                        i.name = correctName
                        i.num = Int(correctNum) ?? 1
                        i.denom = Int(correctDenom) ?? 1
                        i.unit = correctUnit
                        i.id = UUID()
                        
                        ingredients.append(i)
                        
                        name = ""
                        num = "1"
                        denom = "1"
                        unit = ""
                    }
                }, label: {
                    Text("Add")
                })
                
            }
            
            ForEach(ingredients) { i in
                Text("\(i.name), \(i.num!) / \(i.denom!) \(i.unit!)")
            }
            
            
            
        }
    }
}


