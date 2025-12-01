//
//  GratefulMoments1_0App.swift
//  GratefulMoments1.0
//
//  Created by Miguel Angel Bohorquez on 18/11/25.
//

import SwiftUI
import SwiftData

@main
struct GratefulMoments1_0App: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
