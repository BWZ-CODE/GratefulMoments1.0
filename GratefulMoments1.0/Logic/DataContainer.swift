//
//  DataContainer.swift
//  GratefulMoments1.0
//
//  Created by Miguel Angel Bohorquez on 20/11/25.
//

import SwiftData
import SwiftUI


@Observable //El observable es para que el data observe los cambios hechos y los refleje en el UI
@MainActor //
class DataContainer{
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    init(includeSampleMoments: Bool = false) {
        let schema = Schema([//schema ayuda a la migracion de datos
            Moment.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if includeSampleMoments{
            loadSampleMoments()
        }
            try context.save()
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    
    private func loadSampleMoments() {
        for moment in Moment.sampleData{
            context.insert(moment)
        }
    }
}

private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
