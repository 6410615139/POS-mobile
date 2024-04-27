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
    @State private var showingPaymentSheet = false

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.orders ?? [], id: \.self) { order in
                        if isEditMode {
                            OrderEditRow(order: order, viewModel: viewModel, onUpdate: { updatedOrder in
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

            VStack {
                HStack {
                    Text("Total")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                    Text(viewModel.totalString)
                        .font(.title3)
                }
                .padding()

                Button(action: {
                    showingPaymentSheet = true
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
        .sheet(isPresented: $showingPaymentSheet) {
            PaymentProcessingView(viewModel: viewModel)
        }
        .navigationTitle("Table: \(viewModel.item?.table ?? "N/A")")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isEditMode.toggle()
                }) {
                    Image(systemName: isEditMode ? "checkmark.circle" : "gear")
                }
            }
        }
        .onAppear(perform: viewModel.fetchOrders)
    }
}
