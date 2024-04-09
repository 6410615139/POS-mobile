//
//  StockView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//
import SwiftUI

struct StockView: View {
    @StateObject var viewModel = StockViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.products, id: \.id) { product in
                    StockItemView(product: product)
                }
            }
            .navigationTitle("Stock")
            .toolbar {
                Button {
                    viewModel.showingnewProductView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingnewProductView) {
                NewProductView(newProductPresented: $viewModel.showingnewProductView)
            }
            .onAppear {
                Task {
                    await viewModel.fetchPosts()
                }
            }
            .onChange(of: viewModel.showingnewProductView) {
                if !viewModel.showingnewProductView {
                    Task {
                        await viewModel.fetchPosts()
                    }
                }
            }
            
        }
    }
}

// Formatter for displaying the post's creation date
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

