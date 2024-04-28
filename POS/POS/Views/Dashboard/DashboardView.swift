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

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                DashboardSectionView(
                    title: "Sales",
                    iconName: "dollarsign.circle",
                    color: .green,
                    content: "\(viewModel.totalSales)$"
                )
                
                // Displaying best sellers
                VStack(alignment: .leading, spacing: 10) {
                    Text("Best Sellers")
                        .font(.title2)
                        .bold()

                    // Check if there are product counts to display
                    // Displaying product counts in reverse order
                    if !viewModel.myProductCounts.isEmpty {
                        let sortedKeys = viewModel.myProductCounts.keys.sorted {
                            (viewModel.myProductCounts[$0]?.count ?? 0) > (viewModel.myProductCounts[$1]?.count ?? 0)
                        }

                        ForEach(sortedKeys, id: \.self) { key in
                            if let count = viewModel.myProductCounts[key]?.count,
                               let productName = viewModel.myProductCounts[key]?.product.product_name {
                                Text("\(productName): \(count) sold")
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(radius: 3)
                            }
                        }
                    } else {
                        Text("No product sales data available.")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 3)
                    }
                    
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            .background(color.opacity(0.2))
            .cornerRadius(10)

            Text(content)
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}
