//
//  StockItemView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import SwiftUI

struct StockItemView: View {
    @StateObject var viewModel: StockItemViewModel
    @State private var isNavigationActive = false  // State to control navigation

    init(product: Product) {
        _viewModel = StateObject(wrappedValue: StockItemViewModel(product: product))
    }
    
    var body: some View {
        HStack {

            // Tappable area for navigation
            VStack(alignment: .leading) {
                Text("Product: \(viewModel.product.product_name)")
                    .font(.title3)
                    .bold()
                Text("price: \(viewModel.product.price) ฿")
                    .font(.caption)
                    .bold()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isNavigationActive = true
            }
            Spacer()
        }
    }
}
