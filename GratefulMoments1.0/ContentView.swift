//
//  ContentView.swift
//  GratefulMoments1.0
//
//  Created by Miguel Angel Bohorquez on 18/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    
    var body: some View {
        VStack {
            Button("Create a grateful moment"){
                isPresented = true
            }.buttonStyle(.bordered)
                .sheet(isPresented: $isPresented){
                    MomentEntryView()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
