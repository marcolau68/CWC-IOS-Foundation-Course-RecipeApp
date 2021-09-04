//
//  Recipe_List_App.swift
//  Recipe List App
//
//  Created by Marco Lau on 10/08/2021.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
