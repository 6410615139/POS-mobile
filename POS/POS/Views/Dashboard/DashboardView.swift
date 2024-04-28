//
//  DashboardView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 7, alignment: .leading),
        GridItem(.fixed(100), spacing: 7)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                DashboardSectionView(
                    title: "Sales",
                    iconName: "dollarsign.circle",
                    color: Color(UIColor(hex: "#387440")),
                    content: "\(viewModel.totalSales)$"
                )
                
                // Displaying best sellers
                VStack(alignment: .leading, spacing: 10) {
                    Text("Best Sellers")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color(UIColor(hex: "#387440")))

                    // Check if there are product counts to display
                    // Displaying product counts in reverse order
                    if !viewModel.myProductCounts.isEmpty {
                        let sortedKeys = viewModel.myProductCounts.keys.sorted {
                            (viewModel.myProductCounts[$0]?.count ?? 0) > (viewModel.myProductCounts[$1]?.count ?? 0)
                        }

                        ForEach(sortedKeys, id: \.self) { key in
                            if let count = viewModel.myProductCounts[key]?.count,
                               let productName = viewModel.myProductCounts[key]?.product.product_name {
                                
                                LazyVGrid(columns: columns){
                                    Text("\(productName)")
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
                                        .background(Color(UIColor(hex: "#ddedb6")))
                                    Text("\(count) sold")
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .center) // Fill the available width
                                        .background(Color(UIColor(hex: "#ddedb6")))
                                }
                            }
                            
                        }
                    } else {
                        Text("No product sales data available.")
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading) // Fill the available width
                            .background(Color(UIColor(hex: "#ddedb6")))
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
                .cornerRadius(8)
                .shadow(color: Color(UIColor(hex: "#387440")), radius: 3)
            }
            .padding()
        }
    }
}

struct DashboardRow: View {
    var product: Product

    var body: some View {
        HStack {
            Text(product.product_name)
                .bold()
            Spacer()
            Text("\(product.price, specifier: "%.2f")$")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

struct DashboardSectionView: View {
    var title: String
    var iconName: String
    var color: Color
    var content: String

    var body: some View {
        HStack(spacing: 10) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            
            Spacer()

            Text(content)
                .font(.headline)
                .padding(.horizontal)
        }
        .padding()
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(color)
        .cornerRadius(10)
    }
}
