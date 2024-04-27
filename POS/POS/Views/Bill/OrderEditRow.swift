//
//  OrderEditRow.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

struct OrderEditRow: View {
    var order: Order
    var viewModel: BillDetailsViewModel
    var onUpdate: (Order) -> Void
    @State private var amount: Int
    
    init(order: Order, viewModel: BillDetailsViewModel, onUpdate: @escaping (Order) -> Void) {
        self.order = order
        self.viewModel = viewModel
        self._amount = State(initialValue: order.amount)
        self.onUpdate = onUpdate
    }
    
    var columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 5),
        GridItem(.flexible(), spacing: 7, alignment: .leading),
        GridItem(.fixed(100), spacing: 7, alignment: .center)
    ]

    var body: some View {
//        HStack {
        LazyVGrid(columns: columns){
            Button(action: {
                viewModel.deleteOrder(orderId: order.id)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
            .background(.red)
            
            Text(order.product.product_name)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
                .background(.white)
            
            HStack {
                Button(action: {
                    if amount > 1 { amount -= 1 }
                    let newOrder = Order(id: order.id, amount: amount, product: order.product)
                    onUpdate(newOrder)
                    viewModel.updateOrder(order: newOrder, in: viewModel.itemId)
                    onUpdate(Order(id: order.id, amount: amount, product: order.product))
                }) {
                    Image(systemName: "minus.circle")
                }
                Text("\(amount)")
                Button(action: {
                    amount += 1
                    let newOrder = Order(id: order.id, amount: amount, product: order.product)
                    onUpdate(newOrder)
                    viewModel.updateOrder(order: newOrder, in: viewModel.itemId)
                }) {
                    Image(systemName: "plus.circle")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
            .background(.white)
        }
    }
}
