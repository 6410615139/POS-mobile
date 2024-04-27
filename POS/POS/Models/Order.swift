//
//  Order.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation

struct Order: Codable, Identifiable, Hashable {
    let id: String
    var amount: Int
    var product: Product

    // Custom hash function using the synthesizable hash(into:) method provided by Swift
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)       // Combining the unique identifier
        hasher.combine(amount)   // Optionally combine other properties if they should affect the hash
        hasher.combine(product)  // Assuming Product is also Hashable
    }

    // Equatable protocol to compare orders
    static func ==(lhs: Order, rhs: Order) -> Bool {
        return lhs.id == rhs.id && lhs.amount == rhs.amount && lhs.product == rhs.product
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "amount": amount,
            "product": product.toDictionary()  // Convert nested Product to dictionary
        ]
    }
    
}

