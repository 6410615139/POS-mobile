//
//  BillView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct BillView: View {
    
    @StateObject var viewModel: BillViewModel
    @FirestoreQuery var items: [Bill]
    @State private var showDeleteConfirmation = false
    @State private var itemToDelete: Bill? = nil
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    // Specify the size for each item
    private let itemSize: CGSize = CGSize(width: 150, height: 150)
    
    init() {
        self._items = FirestoreQuery(collectionPath: "bills")
        self._viewModel = StateObject(wrappedValue: BillViewModel())
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    // Button for adding a new bill
                    Button(action: viewModel.create_bill) {
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
                    
                    ForEach(items) { item in
                        BillItemView(item: item)
                            .frame(width: itemSize.width, height: itemSize.height)
                            .background(Color(UIColor.systemBackground)) // Use appropriate background color
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
        }
    }
}
