//
//  AddListData.swift
//  Recipe List App
//
//  Created by Marco Lau on 04/09/2021.
//

import SwiftUI

struct AddListData: View {
    
    @Binding var list: [String]
    var title: String
    var example: String
    
    @State var entry = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .bold()
                
                TextField(example, text: $entry)
                
                Button(action: {
                    if entry.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                        self.list.append(entry.trimmingCharacters(in: .whitespacesAndNewlines))
                        entry = ""
                    }
                }, label: {
                    Text("Add")
                })
                .padding(.horizontal)
            }
 
            ForEach(list, id: \.self) { item in
                Text(item)
            }
  
        }
    }
}


