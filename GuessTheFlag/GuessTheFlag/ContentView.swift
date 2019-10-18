//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Usemobile on 18/10/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let count = 5
    
    var body: some View {
        VStack {
            ForEach(0 ..< self.count) {_ in
                HStack {
                    ForEach(0 ..< self.count) { _ in
                        Text("1")
                    }
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
