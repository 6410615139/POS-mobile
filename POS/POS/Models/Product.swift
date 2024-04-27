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
//    var details: String
    var price: Double
//    var image_path: String
//    var catagory: String
    var amount: Int
    
}
