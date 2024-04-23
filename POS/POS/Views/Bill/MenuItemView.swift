//
//  MenuItemView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import SwiftUI

struct MenuItemView: View {
    @StateObject var viewModel: MenuItemViewModel
    var item: Product
    @State private var quantity: Int = 1

    init(billId: String, product: Product) {
        _viewModel = StateObject(wrappedValue: MenuItemViewModel(billId: billId))
        item = product
    }
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.product_name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Price: \(item.price, specifier: "%.2f") ฿")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                Spacer()
            }
            
            HStack(spacing: 20) {
                // Decrease quantity button
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }

                // Quantity display
                Text("\(quantity)")
                    .font(.title)
                    .foregroundColor(.primary)

                // Increase quantity button
                Button(action: {
                    quantity += 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(.title)
                }
            }
            
            // Add to cart button
            Button(action: {
                viewModel.addToCart(product: item, amount: quantity)
            }) {
                Text("Add to Cart")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

