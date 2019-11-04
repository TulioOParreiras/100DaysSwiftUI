//
//  AstronautView.swift
//  Moonshot
//
//  Created by Usemobile on 04/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                }
                Section(header: Text("Missions")) {
                    ForEach(self.missions) {
                        Text($0.displayName)
                            .frame(alignment: .leading)
                    }
                }
            
            }
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        self.missions = missions.filter({ $0.crew.compactMap({ $0.name }).contains(astronaut.id) })
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: self.astronauts[0], missions: self.missions)
    }
}
