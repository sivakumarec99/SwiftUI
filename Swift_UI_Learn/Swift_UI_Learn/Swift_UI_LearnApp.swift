//
//  Swift_UI_LearnApp.swift
//  Swift_UI_Learn
//
//  Created by JIDTP1408 on 05/05/25.
//

import SwiftUI

@main
struct Swift_UI_LearnApp: App {
    let persistenceController = PersistenceController.shared

    let custumUi: Bool = true
    var body: some Scene {
        WindowGroup {
            if custumUi {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }else{
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
