//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Usemobile on 21/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false
    
    var motto1: some View { Text("Draco dormiens") }
    let motto2 = Text("nunquam titillandus")
    
    var body: some View {
        //        Button("Hello World") {
        //            self.useRedText.toggle()
        //        }
        //        .foregroundColor(self.useRedText ? .red : .blue)
        
        //            Button("Hello World") {
        //                print(type(of: self.body))
        //            }
        //            .frame(width: 200, height: 200)
        //            .background(Color.red)
        
        //        Button("Hello World") {
        //            print(type(of: self.body))
        //        }
        //        .background(Color.red)
        //    .frame(width: 200, height: 200)
        //    .background(Color.blue)
        
//        Text("Hello World")
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(Color.red)
//            .edgesIgnoringSafeArea(.all)
        
//        VStack {
//            Text("Gryffindor")
//                .font(.largeTitle)
//                .blur(radius: 0)
//            Text("Hufflepuff")
//            Text("Ravenclaw")
//            Text("Slytherin")
//        }
//        .font(.title)
//        .blur(radius: 5)
        
//        VStack {
//            motto1
//                .foregroundColor(.red)
//            motto2
//                .foregroundColor(.blue)
//        }
        
//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//                .foregroundColor(.white)
//            CapsuleText(text: "Second")
//                .foregroundColor(.yellow)
//        }
        
//        Text("Hello World")
//        .titleStyle()
        
//        Color.blue
//        .frame(width: 300, height: 300)
//        .watermarked(with: "Hacking with Swift")
        
//        GridStack(rows: 4, columns: 4) { (row, colum) in
////            HStack {
//                Image(systemName: "\(row * 4 + colum).circle")
//                Text("R\(row) C\(colum)")
////            }
//        }
        
        Color.red
        .frame(width: 300, height: 300)
        .largeTitle(with: "SwiftUI")
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { colum in
                        self.content(row, colum)
                    }
                }
            }
        }
    }
    
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping(Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(self.text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            
            Text(self.text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TitleModifier: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            
            Text(self.title)
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
    }
}

extension View {
    func largeTitle(with title: String) -> some View {
        self.modifier(TitleModifier(title: title))
    }
}

