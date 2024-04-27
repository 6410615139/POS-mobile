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
    @State private var isPaid = false
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    private let itemSize: CGSize = CGSize(width: 170, height: 140)

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
                    .frame(width: 250, height: 30)
                    
                    Spacer()
                    
                    Button {
                        isPaid.toggle()
                    } label: {
                        Text(isPaid ? "Paid": "Unpaid")
                        Image(systemName: "line.3.horizontal.decrease.circle")

                    }
                    .foregroundColor(Color(UIColor(hex: "#387440")))
                }
                .padding([.horizontal, .top])
                    
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        Button(action: {
                            viewModel.create_bill()
                            shouldNavigate = true  // Set to true to navigate after bill creation
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.white)
                                    .frame(width: 80)
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80)
                                    .padding(20)
                                    .foregroundColor(Color(UIColor(hex: "#387440")))
                            }
                            .frame(width: itemSize.width, height: itemSize.height)
                            .background(Color(UIColor(hex: "#9ED461")))
                            .cornerRadius(10)
                        }
                        
                        ForEach(filteredItems, id: \.id) { item in
                            if (isPaid == item.status) {
                                BillItemView(item: item)
                                    .padding(.horizontal, 5)
                                    .frame(width: itemSize.width, height: itemSize.height)
                                    .background(!item.status ? Color(UIColor(hex: "#387440")) : Color(UIColor(hex: "#CBCBCB")))
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
                        // Hidden NavigationLink
                        NavigationLink(destination: MenuView(billId: viewModel.newBillId), isActive: $shouldNavigate) {
                            EmptyView()
                        }
                    }
                }
                .padding([.horizontal, .top])
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
