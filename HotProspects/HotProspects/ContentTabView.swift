//
//  ContentTabView.swift
//  HotProspects
//
//  Created by Usemobile on 16/12/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentTabView: View {
    
    var prospects = Prospects() 
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
            }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
            }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
            }
            
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
            }
        }
            .environmentObject(prospects)
    }
    
}

struct ContentTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentTabView()
    }
    
}
