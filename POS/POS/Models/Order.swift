//
//  Order.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation

struct Order: Codable , Identifiable{
    let id: String
    var amount: Int
    var product: Product
    
}
