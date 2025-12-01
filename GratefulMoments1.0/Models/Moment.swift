//
//  Moment.swift
//  GratefulMoments1.0
//
//  Created by Miguel Angel Bohorquez on 19/11/25.
//

import Foundation
import SwiftData
import UIKit //El UIKit se trae para convertir la imagen de tipo Data a tipo UI para que sea visible

@Model //Esto es para que lo que el user escriba, se pueda guardar

class Moment {
    var title: String
    var note: String
    var imageData: Data?
    var timestamp: Date
    
    init(title: String, note: String, imageData: Data? = nil, timestamp: Date = .now){
        self.title = title
        self.note = note
        self.imageData = imageData
        self.timestamp = timestamp
        
    }
    
    var image: UIImage?{
        imageData.flatMap{//Se usa flatMap solo cuando la imagen no sea un opcional, o sea cuando la elijamos
            UIImage(data: $0)
        }
    }
}

extension Moment {
    static let sample = sampleData[0]
    static let longTextSample = sampleData[1]
    static let imageSample = sampleData[4]


    static let sampleData = [
        Moment(
            title: "🍅🥳",
            note: "Picked my first homegrown tomato!"
        ),
        Moment(
            title: "Passed the test!",
            note: "The chem exam was tough, but I think I did well 🙌 I’m so glad I reached out to Guillermo and Lee for a study session. It really helped!",
            imageData: UIImage(named: "Study")?.pngData()
        ),
        Moment(
            title: "Down time",
            note: "So grateful for a relaxing evening after a busy week.",
            imageData: UIImage(named: "Relax")?.pngData()
        ),
        Moment(
            title: "Family ❤️",
            note: ""
        ),
        Moment(
            title: "Rock on!",
            note: "Went to a great concert with Blair 🎶",
            imageData: UIImage(named: "Concert")?.pngData()
        )
    ]
}
