//
//  BillItemView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import SwiftUI

struct BillItemView: View {
    @StateObject var viewModel = BillItemViewModel()
    let item: Bill
    @State private var isNavigationActive = false  // State to control navigation

    var body: some View {
        HStack {
            NavigationLink(destination: MenuView(billId: item.id), isActive: $isNavigationActive) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)

            // Tappable area for navigation
            VStack(alignment: .leading) {
                Text("Table: \(item.table)")
                    .font(.title3)
                    .bold()
                Text("Owner: \(item.owner)")
                    .font(.caption)
                    .bold()
                Text("Create at: \(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(UIColor(hex: "#ddedb6")))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isNavigationActive = true
            }
            .background(NavigationLink("", destination: MenuView(billId: item.id)).hidden())
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.horizontal,5)
    }
}
