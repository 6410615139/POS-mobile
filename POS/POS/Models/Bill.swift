//
//  Bill.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation

struct Bill: Codable, Identifiable {
    let id: String
    var table: String
    let createDate: TimeInterval
    var orders: [Order]
    let owner: String
    var status: Bool
    
    mutating func set_table(_ table: String) {
        self.table = table
    }
    
    func total() -> Double {
        var result: Double = 0.0
        for order in orders {
            result += (Double(order.amount) * order.product.price)
        }
        return result
    }
}

