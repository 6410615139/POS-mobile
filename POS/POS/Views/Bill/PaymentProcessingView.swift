//
//  PaymentProcessingView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import SwiftUI

// Assume you have a PaymentProcessingView defined elsewhere
struct PaymentProcessingView: View {
    var viewModel: BillDetailsViewModel

    var body: some View {
        Text("QRView")
        AsyncImage(url: URL(string: "https://promptpay.io/0656549690.png/\(viewModel.totalString)"))
                        .frame(width: 350, height: 350)
    }
}
