//
//  BillDetailsView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct BillDetailsView: View {
    @StateObject var viewModel: BillDetailsViewModel
    @State private var isEditMode = false // State to toggle edit mode

    var body: some View {
        VStack {
            // Orders List
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.orders ?? [], id: \.self) { order in
                        if isEditMode {
                            OrderEditRow(order: order, onUpdate: { updatedOrder in
                                if let index = viewModel.orders?.firstIndex(where: { $0.id == updatedOrder.id }) {
                                    viewModel.orders?[index] = updatedOrder
                                }
                            })
                        } else {
                            OrderRow(order: order)
                        }
                    }
                }
                .padding(.horizontal)
            }

            // Total and Payment (assuming total is calculated)
            VStack {
                HStack {
                    Text("Total")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    // Assuming there's a method to calculate the total
                    // Text(viewModel.totalString)
                    // .font(.title3)
                }
                .padding()

                Button(action: {
                    // Implement the payment action
                }) {
                    Text("PAYMENT")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Table: \(viewModel.item?.table ?? "N/A")")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditMode.toggle()
                }) {
                    Image(systemName: "gear")
                }
            }
        }
    }

    // Helper function to format the date
    private func formatTime(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct DetailField: View {
    var label: String
    var value: String
    var font: Font

    var body: some View {
        HStack {
            Text(label + ":")
                .font(font)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(font)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct OrderRow: View {
    var order: Order

    var body: some View {
        HStack {
            Text(order.product.product_name)
                .font(.headline)
            Spacer()
            Text("x\(order.amount)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct OrderEditRow: View {
    var order: Order
    var onUpdate: (Order) -> Void
    
    @State private var amount: Int
    
    init(order: Order, onUpdate: @escaping (Order) -> Void) {
        self.order = order
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
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
    }
}
