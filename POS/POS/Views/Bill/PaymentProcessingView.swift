//
//  PaymentProcessingView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

struct PaymentProcessingView: View {
    @ObservedObject var viewModel: BillDetailsViewModel  // Ensure viewModel is observed for changes

    var body: some View {
        VStack {
            Text("Scan to Pay")
            AsyncImage(url: URL(string: "https://promptpay.io/0656549690.png/\(viewModel.totalString)"))
            .frame(width: 350, height: 350)
            .cornerRadius(8)

            Button{
                // This sets the bill status to true indicating it has been paid
                viewModel.updateBillStatus(value: true)
            } label: {
                HStack{
                    Image(systemName: "checkmark.circle")
                    Text("Mark as Paid")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color(UIColor(hex: "#387440")))
            }
            .padding()
            
        }
    }
}
