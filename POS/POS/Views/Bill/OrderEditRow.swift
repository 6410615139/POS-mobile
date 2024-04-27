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

    var body: some View {
        HStack {
            Text(order.product.product_name)
                .font(.headline)
            Spacer()
            HStack {
                Button(action: {
                    if amount > 1 { amount -= 1 }
                    onUpdate(Order(id: order.id, amount: amount, product: order.product))
                }) {
                    Image(systemName: "minus.circle")
                }
                Text("x\(amount)")
                    .font(.subheadline)
                Button(action: {
                    amount += 1
                    onUpdate(Order(id: order.id, amount: amount, product: order.product))
                }) {
                    Image(systemName: "plus.circle")
                }
                Button(action: {
                    viewModel.deleteOrder(orderId: order.id)
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
