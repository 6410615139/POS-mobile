//
//  StockView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct StockView: View {
    var user: User
    @State private var shouldNavigate = false
    @StateObject var viewModel: StockViewModel
    @State private var searchQuery = ""
    @FirestoreQuery(collectionPath: "products") var allItems: [Product]
    @State private var showDeleteConfirmation = false
    @State private var itemToDelete: Product? = nil
    @State private var showingNewProductSheet = false  // State to control the visibility of the new product sheet
    @State private var isEditMode = false  // State to toggle edit mode
    
    private let itemSize: CGSize = CGSize(width: 150, height: 150)
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: StockViewModel())
        self.user = user
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
                        if isEditMode {
                            ProductEditRow(product: item, viewModel: viewModel, onUpdate: { updatedProduct in
                                if let index = viewModel.products.firstIndex(where: { $0.id == updatedProduct.id }) {
                                    viewModel.products[index] = updatedProduct
                                }
                            })
                        } else {
                            ProductRow(product: item)
                        }
                    }
                }
                .padding()
                .confirmationDialog("Are you sure you want to delete this item?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        if let deleteItem = itemToDelete {
//                            viewModel.deleteProduct(deleteItem)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
            .navigationTitle("Stock")
            .toolbar {
                if user.role.isOwner || user.role.isManager {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingNewProductSheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditMode.toggle()
                    }) {
                        Image(systemName: isEditMode ? "checkmark.circle" : "gear")
                    }
                }
            }
            .sheet(isPresented: $showingNewProductSheet) {
                NewProductView(newProductPresented: $showingNewProductSheet)
            }
        }
    }
}
