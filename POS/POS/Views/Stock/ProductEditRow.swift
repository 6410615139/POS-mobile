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
    
    var columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 5),
        GridItem(.flexible(), spacing: 7, alignment: .leading),
        GridItem(.fixed(100), spacing: 7)
    ]

    var body: some View {
        //        HStack {
        LazyVGrid(columns: columns){
            Button(action: {
                viewModel.deleteProduct(productId: product.id)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
            .background(.red)
            
            Text(product.product_name)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
                .background(Color(UIColor(hex: "#ddedb6")))
            
            HStack {
                Button(action: {
                    if amount > 0 { amount -= 1 }
                    let newProduct = Product(id: product.id, product_name: product.product_name, price: product.price, amount: amount)
                    onUpdate(newProduct)
                    viewModel.updateProduct(newProduct)
                }) {
                    Image(systemName: "minus.circle")
                }
                Text("\(amount)")
                Button(action: {
                    amount += 1
                    let newProduct = Product(id: product.id, product_name: product.product_name, price: product.price, amount: amount)
                    onUpdate(newProduct)
                    viewModel.updateProduct(newProduct)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
            .background(Color(UIColor(hex: "#ddedb6")))
        }
        
    }
}
