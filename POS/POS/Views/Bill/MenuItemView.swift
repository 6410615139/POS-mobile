//
//  MenuItemView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import SwiftUI

import SwiftUI

struct MenuItemView: View {
    @StateObject var viewModel = MenuItemViewModel()
    let item: Product
    @State private var isNavigationActive = false  // State to control navigation

    var body: some View {
        HStack {

            // Tappable area for navigation
            VStack(alignment: .leading) {
                Text("Product: \(item.product_name)")
                    .font(.title3)
                    .bold()
                Text("Price: \(item.price) ฿")
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

