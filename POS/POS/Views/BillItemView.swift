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
            // NavigationLink disguised as part of the HStack content
            NavigationLink(destination: BillDetailsView(itemId: item.id), isActive: $isNavigationActive) {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)

            // Tappable area for navigation
            VStack(alignment: .leading) {
                Text("Test word")
                    .font(.title)
                    .bold()
                
                Text("\(Date(timeIntervalSince1970: item.createDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(Color(.secondaryLabel))
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isNavigationActive = true
            }
            .background(NavigationLink("", destination: BillDetailsView(itemId: item.id)).hidden())

            Spacer()
        }
    }
}