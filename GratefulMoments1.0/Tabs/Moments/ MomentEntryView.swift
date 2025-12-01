//
//   MomentEntryView.swift
//  GratefulMoments1.0
//
//  Created by Miguel Angel Bohorquez on 18/11/25.
//

import SwiftUI
import PhotosUI
import SwiftData


struct MomentEntryView: View {
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var newImage: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var isShowingCancelConfirmation: Bool = false
    
    
    @Environment(\.dismiss) private var dismiss
    @Environment(DataContainer.self) private var dataContainer
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
                photoPicker
            }.scrollDismissesKeyboard(.interactively)
                .navigationTitle("Grateful for")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("cancel", systemImage: "xmark"){
                            if title.isEmpty, note.isEmpty, imageData == nil {
                                dismiss()
                                
                            }else{
                                isShowingCancelConfirmation = true
                            }
                        }.confirmationDialog("Discard Moment", isPresented: $isShowingCancelConfirmation){
                            Button("Discard Moment", role: .destructive){
                                dismiss()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add", systemImage: "checkmark"){
                            let newMoment = Moment(
                                title : title,
                                note : note,
                                imageData : imageData,
                                timestamp: .now
                            )
                            dataContainer.context.insert(newMoment)
                            do{
                                try dataContainer.context.save()
                                dismiss()
                            }catch{
                                
                            }
                        }
                        .disabled(title.isEmpty)
                    }
                }
        }
    }
    
    private var photoPicker: some View {
        
        PhotosPicker(selection:$newImage) {
            Group {
                if let imageData, let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()

                }
                else {
                    Image(systemName: "photo.badge.plus.fill")
                        .font(.largeTitle)
                        .frame(height: 250)
                        .frame(maxWidth:.infinity)
                        .background(Color(white:0.4,opacity: 0.32))
                }
                    
            }.clipShape(RoundedRectangle(cornerRadius: 32))
                .padding()
        }.onChange(of: newImage){
            guard let newImage else {return}
            Task {
                imageData = try await newImage.loadTransferable(type: Data.self)
            }
        }
        
    }
    
    var contentStack: some View {
        VStack(alignment:.leading) {
            TextField(text:$title){
                Text("Title")
            }.font(.title.bold())
                .padding(.top,48)
            Divider()
            TextField("Log your small wins", text: $note,axis: .vertical).multilineTextAlignment(.leading)
                .lineLimit(5...Int.max)
            
        }
        .padding()
    }
}

#Preview {
    MomentEntryView()
        .sampleDataContainer()
}
