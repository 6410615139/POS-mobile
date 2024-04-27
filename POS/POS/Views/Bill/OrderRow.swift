//
//  OrderRow.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

struct OrderRow: View {
    var order: Order

    var body: some View {
        HStack {
            Text(order.product.product_name)
                .font(.headline)  // Prominent font for the product name
            Spacer()  // Pushes the text to the left and number to the right
            Text("x\(order.product.price)")
                .font(.subheadline)  // Slightly smaller font for the amount
                .foregroundColor(.secondary)
            Text("x\(order.amount)")  // Displays the amount of the product ordered
                .font(.subheadline)  // Slightly smaller font for the amount
                .foregroundColor(.secondary)  // Greyed out color for less emphasis
        }
        .padding()  // Padding around the HStack content
        .background(Color(UIColor.secondarySystemBackground))  // Light grey background to differentiate rows
        .cornerRadius(8)  // Rounded corners for a smooth design
    }
}
