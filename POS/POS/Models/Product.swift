//
//  Product.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: String
    var product_name: String
    var price: Double
    var amount: Int
    
    func toDictionary() -> [String: Any] {
            return [
                "product_name": product_name,
                "price": price,
                "amount": amount
            ]
        }
}
