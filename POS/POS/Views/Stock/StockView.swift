//
//  StockView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct StockView: View {
    @State private var shouldNavigate = false
    @StateObject var viewModel: StockViewModel
    @State private var searchQuery = ""
    @FirestoreQuery(collectionPath: "products") var allItems: [Product]
    @State private var showDeleteConfirmation = false
    @State private var itemToDelete: Product? = nil
    @State private var showingNewProductSheet = false  // State to control the visibility of the new product sheet
    
    private let itemSize: CGSize = CGSize(width: 150, height: 150)
    
    init() {
        self._viewModel = StateObject(wrappedValue: StockViewModel())
    }
    
    var filteredItems: [Product] {
        if searchQuery.isEmpty {
            return allItems
        } else {
            return allItems.filter { item in
                item.product_name.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search products...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                ScrollView {
                    ForEach(filteredItems, id: \.id) { item in
                        ProductRow(product: item)
                    }
                }
                .padding()
            }
            .navigationTitle("Stock")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewProductSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewProductSheet) {
                NewProductView(newProductPresented: $showingNewProductSheet)
            }
        }
    }
}
