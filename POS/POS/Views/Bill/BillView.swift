//
//  BillView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct BillView: View {
    
    @State private var shouldNavigate = false
    @StateObject var viewModel: BillViewModel
    @State private var searchQuery = ""
    @FirestoreQuery(collectionPath: "bills") var allItems: [Bill]
    @State private var showDeleteConfirmation = false
    @State private var itemToDelete: Bill? = nil
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    private let itemSize: CGSize = CGSize(width: 150, height: 150)

    init() {
        self._viewModel = StateObject(wrappedValue: BillViewModel())
    }
    
    var filteredItems: [Bill] {
        if searchQuery.isEmpty {
            return allItems
        } else {
            return allItems.filter { item in
                item.table.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search bills...", text: $searchQuery)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        Button(action: {
                            viewModel.create_bill()
                            shouldNavigate = true  // Set to true to navigate after bill creation
                        }) {
                            VStack {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(20)
                            }
                            .frame(width: itemSize.width, height: itemSize.height)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                        }
                        
                        ForEach(filteredItems, id: \.id) { item in
                            BillItemView(item: item)
                                .frame(width: itemSize.width, height: itemSize.height)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .overlay(
                                    VStack {
                                        if itemToDelete?.id == item.id {
                                            Button("Delete") {
                                                showDeleteConfirmation = true
                                            }
                                            .padding()
                                            .background(Color.red)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                        }
                                    }
                                )
                                .onLongPressGesture {
                                    itemToDelete = item
                                }
                        }
                        // Hidden NavigationLink
                        NavigationLink(destination: MenuView(billId: viewModel.newBillId), isActive: $shouldNavigate) {
                            EmptyView()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Bills")
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete this bill?"),
                    primaryButton: .destructive(Text("Delete")) {
                        if let item = itemToDelete {
                            viewModel.delete(id: item.id)
                            itemToDelete = nil
                        }
                    },
                    secondaryButton: .cancel {
                        itemToDelete = nil
                    }
                )
            }
            .onTapGesture {
                itemToDelete = nil
            }
        }
    }
}
