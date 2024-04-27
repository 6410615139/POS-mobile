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
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(UIColor(hex: "#9ED461")))
                            .padding(.leading, 2)
                        
                        TextField("SEARCH", text: $searchQuery)
                        
                        if !searchQuery.isEmpty {
                            Button(action: {
                                searchQuery = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(UIColor(hex: "#9ED461")))
                                    .padding(.trailing, 3)
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .background(Color.white)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(UIColor(hex: "#9ED461")), lineWidth: 3)
                    )
                    .frame(width: 270, height: 30)
                    Spacer()
                }
                .padding([.horizontal, .top])
                
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
                                .foregroundColor(Color(UIColor(hex: "#387440")))
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditMode.toggle()
                    }) {
                        Image(systemName: isEditMode ? "checkmark.circle" : "gear")
                            .foregroundColor(Color(UIColor(hex: "#387440")))
                    }
                }
            }
            .sheet(isPresented: $showingNewProductSheet) {
                NewProductView(newProductPresented: $showingNewProductSheet)
            }
        }
    }
}
