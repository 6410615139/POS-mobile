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
    @State private var navigateToBillDetails = false

    init(billId: String, product: Product) {
        _viewModel = StateObject(wrappedValue: MenuItemViewModel(billId: billId))
        item = product
    }
    
    var body: some View {
        VStack{
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
            
            HStack{
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
            .padding(.bottom,3)
            
            // Add to cart button
            Button{
                viewModel.addToCart(product: item, amount: quantity)
                navigateToBillDetails = true
            } label: {
                Text("Add to Cart")
                    .frame(width: 150, height: 30)
                    .bold()
                    .foregroundColor(.white)
                    .background(Color(UIColor(hex: "#9ED461")))
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
