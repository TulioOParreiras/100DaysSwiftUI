//
//  NewOrder.swift
//  CupcakeCorner
//
//  Created by Usemobile on 21/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import Foundation
//
//  Order.swift
//  CupcakeCorner
//
//  Created by Usemobile on 21/11/19.
//  Copyright © 2019 Usemobile. All rights reserved.
//

import UIKit

struct OrderModel: Codable {
    
    var type = 0
    var quantity = 3
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
}

class NewOrder: ObservableObject {
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var order: OrderModel = OrderModel()
    
    @Published var specialRequestEnabled = false {
        didSet {
            if !self.specialRequestEnabled {
                self.order.extraFrosting = false
                self.order.addSprinkles = false
            }
        }
    }
    
    var hasValidAddress: Bool {
        if self.order.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            self.order.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            self.order.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            self.order.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(self.order.quantity) * 2
        cost += Double(self.order.type) / 2
        
        if self.order.extraFrosting {
            cost += Double(self.order.quantity)
        }
        
        if self.order.addSprinkles {
            cost += Double(self.order.quantity) / 2
        }
        
        return cost
    }
    
    init() { }
    
    
}
