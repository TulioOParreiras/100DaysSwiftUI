//
//  ContentView.swift
//  Accessibility
//
//  Created by Usemobile on 09/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    @State private var estimate = 25.0
    @State private var rating = 3
    
    var body: some View {
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            .accessibility(value: Text("\(rating) out of 5"))
        
//        Slider(value: $estimate, in: 0...50)
//            .padding()
//            .accessibility(value: Text("\(Int(estimate))"))
        
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
////        .accessibilityElement(children: .combine)
//        .accessibilityElement(children: .ignore)
//        .accessibility(label: Text("Your score is 1000"))
        
//        Image(decorative: "ales-krivec-15949")
//            .accessibility(hidden: true)
        
//        Image(pictures[selectedPicture])
//        .resizable()
//        .scaledToFit()
//        .accessibility(label: Text(labels[selectedPicture]))
//        .accessibility(addTraits: .isButton)
//        .accessibility(removeTraits: .isImage)
//            .onTapGesture {
//                self.selectedPicture = Int.random(in: 0...3)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
