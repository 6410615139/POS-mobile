//
//  ProductRow.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

struct ProductRow: View {
    var product: Product

    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 7, alignment: .leading),
        GridItem(.fixed(100), spacing: 7)
    ]

    var body: some View {
//        HStack {
            LazyVGrid(columns: columns){
                Text(product.product_name)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
                    .background(Color(UIColor(hex: "#ddedb6")))
                
                Text("x\(product.amount)")
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                    .padding()
                    .frame(maxWidth: .infinity) // Fill the available width
                    .background(Color(UIColor(hex: "#ddedb6")))
            }
//        }
    }
}
