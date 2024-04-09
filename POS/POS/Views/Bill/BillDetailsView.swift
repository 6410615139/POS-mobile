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
    
    private var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(itemId: String) {
        _viewModel = StateObject(wrappedValue: BillDetailsViewModel(itemId: itemId))
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                if let item = viewModel.item {
                    // First column content
                    VStack(alignment: .leading, spacing: 10) {
                        // Add content specific to the first column here
                        // For example, show part of the item details
                        Text("Product: \(item.orders)")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)

                } else {
                    Text("Loading details...")
                        .font(.body)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle("Table: \(String(describing: viewModel.item?.table))")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Toolbar items here
        }
        .onChange(of: viewModel.showingEditView) {
            viewModel.fetch_item()
        }
    }
}
