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
    @State private var isNavigationActive = false  // State to control navigation

    init(billId: String, product: Product) {
        _viewModel = StateObject(wrappedValue: MenuItemViewModel(billId: billId))
        item = product
    }
    
    var body: some View {
        HStack {
//            NavigationLink(destination: MenuView(billId: item.id), isActive: $isNavigationActive) {
//                EmptyView()
//            }
//            .frame(width: 0)
//            .opacity(0)

            // Tappable area for navigation
            VStack(alignment: .leading) {
                Text("Product: \(item.product_name)")
                    .font(.title3)
                    .bold()
                Text("price: \(item.price) ฿")
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
