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
    @State private var isNavigateToMenuView = false
    @State private var isNavigateToBillDetailView = false

    var body: some View {
        HStack {
            NavigationLink(destination: MenuView(billId: item.id), isActive: $isNavigateToMenuView) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            
            NavigationLink(destination: BillDetailsView(viewModel: BillDetailsViewModel(itemId: item.id)), isActive: $isNavigateToBillDetailView) {
               EmptyView()
           }
            

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
                    .foregroundColor(!item.status ? Color(UIColor(hex: "#ddedb6")) : .gray)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if item.status {
                    isNavigateToBillDetailView = true
                } else {
                    isNavigateToMenuView = true
                }
            }
            .background(NavigationLink("", destination: MenuView(billId: item.id)).hidden())
            Spacer()
        }
        .foregroundColor(!item.status ? .white : .black)
        .padding(.horizontal,5)
    }
}
