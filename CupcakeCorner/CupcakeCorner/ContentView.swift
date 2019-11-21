//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Usemobile on 21/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
//    @ObservedObject var order = Order()
    @ObservedObject var order = NewOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type",
                           selection: $order.order.type) {
                            ForEach(0 ..< Order.types.count, id: \.self) {
                                Text(Order.types[$0])
                            }
                    }
                    
                    Stepper(value: $order.order.quantity,
                            in: 3...20) {
                                Text("Number of cakes: \(order.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: self.order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}
//
//class User: ObservableObject, Codable {
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    @Published var name = "Paul Hudson"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}
//
//struct ContentView: View {
//
//    @State var userName = ""
//    @State var email = ""
//
//    var disabledForm: Bool {
//        userName.count < 5 || email.count < 5
//    }
//
//    @State var results = [Result]()
//
//    var body: some View {
//        Form {
//            Section {
//                TextField("Username", text: $userName)
//                TextField("Email", text: $email)
//            }
//
//            Section {
//                Button("Create account") {
//                    print("Creating account...")
//                }
//            }
//            .disabled(self.disabledForm)
//        }
//
////        List(results, id: \.trackId) { item in
////            VStack(alignment: .leading) {
////                Text(item.trackName)
////                    .font(.headline)
////
////                Text(item.collectionName)
////            }
////        }
////        .onAppear(perform: loadData)
//    }
//
//    func loadData() {
//        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//            print("Invalid URL")
//            return
//        }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.results = decodedResponse.results
//                    }
//                    return
//                }
//            }
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//        }.resume()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
