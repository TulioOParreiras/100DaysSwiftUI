//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Usemobile on 18/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingAlert = false
    
    let count = 5
    
    var body: some View {
//        VStack {
//            ForEach(0 ..< self.count) {_ in
//                HStack {
//                    ForEach(0 ..< self.count) { _ in
//                        Text("1")
//                    }
//                }
//            }
//        }
        
//        ZStack {
////            Color.red.frame(width: 200, height: 200)
////            Color(red: 1, green: 0.8, blue: 0)
////            Color.red.edgesIgnoringSafeArea(.all)
//            Text("Your content")
//            .background(Color.red)
//        }
        
//        LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
//        RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 20, endRadius: 200)
//        AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
        
//        Button(action: {
//            print("Button was tapped")
//        }) {
//            HStack(spacing: 10) {
//                Image(systemName: "pencil")
//                Text("Edit")
//            }
//            .foregroundColor(.purple)
//        }
//        Button("Tap me!") {
//            print("Button was tapped")
//        }
        
//        Button("Show Alert") {
//            self.showingAlert = true
//        }.alert(isPresented: $showingAlert) {
//            Alert(title: Text("Hello SwiftUI"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
//        }
        
        ZStack{
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        // flad was tapped
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                }
                Spacer()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
