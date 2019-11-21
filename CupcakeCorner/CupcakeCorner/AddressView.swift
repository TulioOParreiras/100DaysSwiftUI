//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Usemobile on 21/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    
    //    @ObservedObject var order = Order()
        @ObservedObject var order = NewOrder()
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street Address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: self.order)) {
                    Text("Check out")
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: NewOrder()) 
    }
}
