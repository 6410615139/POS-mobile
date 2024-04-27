//
//  NewProductView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import SwiftUI

struct NewProductView: View {
    
    @StateObject var viewModel = NewProductViewModel()
    @Binding var newProductPresented: Bool
    
    // Computed property to handle the conversion between Double and String for price
    private var priceBinding: Binding<String> {
        Binding<String>(
            get: {
                String(format: "%.2f", viewModel.price) // Convert Double to String
            },
            set: {
                if let value = NumberFormatter().number(from: $0)?.doubleValue {
                    viewModel.price = value // Update the Double value when the String changes
                }
            }
        )
    }
    
    private var amountBinding: Binding<String> {
        Binding<String>(
            get: {
                String(format: "%d", viewModel.amount)
            },
            set: {
                if let value = NumberFormatter().number(from: $0)?.intValue {
                    viewModel.amount = value // Update the Double value when the String changes
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                TextField("Product Name", text: $viewModel.product_name)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                // Use the custom binding for price
                TextField("Price", text: priceBinding)
                    .keyboardType(.decimalPad) // Show numeric keyboard
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Amount", text: amountBinding)
                    .keyboardType(.decimalPad) // Show numeric keyboard
                    .textFieldStyle(DefaultTextFieldStyle())
                
                POSButton(title: "Save", background: .pink) {
                    viewModel.save()
                    newProductPresented = false
                }
            }
        }
    }
}
