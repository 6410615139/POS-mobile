//
//  ProductEditRow.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

struct ProductEditRow: View {
    var product: Product
    var viewModel: StockViewModel
    var onUpdate: (Product) -> Void
    @State private var amount: Int
    
    init(product: Product, viewModel: StockViewModel, onUpdate: @escaping (Product) -> Void) {
        self.product = product
        self.viewModel = viewModel
        self._amount = State(initialValue: product.amount)
        self.onUpdate = onUpdate
    }

    var body: some View {
        HStack {
            Text(product.product_name)
                .font(.headline)
            Spacer()
            HStack {
                Button(action: {
                    if amount > 0 { amount -= 1 }
                    let newProduct = Product(id: product.id, product_name: product.product_name, price: product.price, amount: amount)
                    onUpdate(newProduct)
                    viewModel.updateProduct(newProduct)
                }) {
                    Image(systemName: "minus.circle")
                }
                Text("x\(amount)")
                    .font(.subheadline)
                Button(action: {
                    amount += 1
                    let newProduct = Product(id: product.id, product_name: product.product_name, price: product.price, amount: amount)
                    onUpdate(newProduct)
                    viewModel.updateProduct(newProduct)
                }) {
                    Image(systemName: "plus.circle")
                }
                Button(action: {
                    viewModel.deleteProduct(productId: product.id)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}
