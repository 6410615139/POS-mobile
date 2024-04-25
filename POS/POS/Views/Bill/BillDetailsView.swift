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
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Table \(viewModel.item?.table)")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "gear")
            }
            .padding()
            
            // Details Section
            VStack(alignment: .leading, spacing: 4) {
//                DetailField(label: "Staff", value: viewModel.item?.staff ?? "")
//                DetailField(label: "Time", value: String(viewModel.item?.createDate ?? ""))
//                DetailField(label: "Status", value: viewModel.item?.status ?? "")
            }
            .padding(.horizontal)
            
            // Orders List
            ScrollView {
                LazyVStack(spacing: 12) {
//                    ForEach(viewModel.orders ?? [], id: \.self) { order in
//                        OrderRow(order: order)
//                    }
                }
                .padding(.horizontal)
            }
            
            // Total and Payment
            VStack {
                HStack {
                    Text("Total")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
//                    Text(viewModel.totalString)
                        .font(.title3)
                }
                .padding()
                
//                Button(action: viewModel.pay) {
//                    Text("PAYMENT")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
            }
        }
        .navigationTitle("Table: \(viewModel.item?.table ?? "")")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailField: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label + ":")
                .foregroundColor(.gray)
            Spacer()
            Text(value)
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
