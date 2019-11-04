//
//  ContentView.swift
//  Moonshot
//
//  Created by Usemobile on 04/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingDate = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    Image(mission.image)
                    .resizable()
                        .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                        if self.showingDate {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text(mission.crewNames)
                        }
                    }
                }
            }
        .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button((self.showingDate ? "Crew" : "Date")) {
                self.showingDate.toggle()
            })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}








////struct CustomText: View {
////    var text: String
////
////    var body: some View {
////        Text(text)
////    }
////
////    init(_ text: String) {
////        print("Creating a CustomText")
////        self.text = text
////    }
////}
//
//struct ContentView: View {
//    var body: some View {
////        Button("Decode JSON") {
////            let input = """
////            {
////                "name": "Taylor Swift",
////                "address": {
////                    "street": "555, Taylor Swift Avenue",
////                    "city": "Nashville"
////                }
////            }
////            """
////
////            struct User: Codable {
////                var name: String
////                var address: Address
////            }
////
////            struct Address: Codable {
////                var street: String
////                var city: String
////            }
////
////            let data = Data(input.utf8)
////            let decoder = JSONDecoder()
////
////
////            if let user = try? decoder.decode(User.self, from: data) {
////                print(user.address.street)
////            }
////        }
//
////        NavigationView {
////            List(0 ..< 100) { row in
////                NavigationLink(destination: Text("Detail \(row)")) {
////                    Text("Row \(row)")
////                }
////            }
////            .navigationBarTitle("SwiftUI")
////        }
//
////        ScrollView(.vertical) {
////            List {
////                ForEach(0 ..< 100) {
////                    CustomText("Item \($0)")
////                        .font(.title)
////                }
////            }
////            .frame(maxWidth: .infinity)
////        }
//
////        VStack {
////            GeometryReader { geo in
////                Image("Example")
////                    .resizable()
////                    .aspectRatio(contentMode: .fill)
////                    .frame(width: geo.size.width)
////            }
////        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
