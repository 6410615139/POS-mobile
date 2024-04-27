//
//  OrderRow.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

struct OrderRow: View {
    var order: Order
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 7, alignment: .leading),
        GridItem(.fixed(100), spacing: 7, alignment: .center)
    ]

    var body: some View {
        LazyVGrid(columns: columns){
            HStack{
                Text(order.product.product_name)
                    .font(.headline)
                Text(String(format: "x%.2f", order.product.price))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
            .background(.white)
            
            Text("x\(order.amount)")
                .padding()
                .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
                .background(.white)
        }
    }
}
