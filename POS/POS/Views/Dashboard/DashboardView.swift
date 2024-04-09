//
//  DashboardView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Sales Section
                DashboardSectionView(title: "Sales", iconName: "dollarsign.circle", color: .green, content: "9,999$")
                
                // Best Seller Section
                DashboardSectionView(title: "Best Seller", iconName: "star.circle", color: .blue, content: "Pizzaa")
                
                // Income/Expenses Section
                DashboardSectionView(title: "Income/Expenses", iconName: "arrow.triangle.2.circlepath", color: .orange, content: "Profit 50$")
            }
            .padding()
        }
    }
}

struct DashboardSectionView: View {
    var title: String
    var iconName: String
    var color: Color
    var content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(color)
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding()
            .background(color.opacity(0.2))
            .cornerRadius(10)
            
            Text(content)
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    DashboardView()
}
