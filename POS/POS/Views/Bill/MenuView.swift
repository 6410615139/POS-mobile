//
//  MenuView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

struct MenuView: View {
    @StateObject var viewModel: MenuViewModel
    @FirestoreQuery(collectionPath: "products") var allItems: [Product]
    @State private var billId: String
    @State private var table: String = ""
    @State private var owner: String = ""
    @State private var searchQuery = ""  // For product search
    @State private var navigateToBillDetails = false  // State for navigation
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 7),
        GridItem(.flexible(), spacing: 7)
    ]

    private let itemSize: CGSize = CGSize(width: 170, height: 170)

    init(billId: String) {
        self._viewModel = StateObject(wrappedValue: MenuViewModel())
        self.billId = billId
    }

    // Filtered items based on search query
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
            ScrollView {
                VStack(alignment: .leading) {
                    // Input fields for table and owner
                    VStack{
                        HStack {
                            VStack{
                                HStack{
                                    Text("Table")
                                        .font(.subheadline)
                                        .foregroundColor(Color(UIColor(hex: "#387440")))
                                    TextField("Table Number", text: $table)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                HStack{
                                    Text("Owner")
                                        .font(.subheadline)
                                        .foregroundColor(Color(UIColor(hex: "#387440")))
                                    TextField("Owner's Name", text: $owner)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                            }
                            
                            // Button to update bill details
                            Button{
                                updateBillDetails()
                            } label: {
                                Text("UPDATE")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color(UIColor(hex: "#387440")))
                                    .cornerRadius(8)
                            }
                            .padding(.leading)
                        }
                        
//                        // Button to update bill details
//                        Button("Update Bill Details") {
//                            updateBillDetails()
//                        }
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .foregroundColor(.white)
//                        .background(Color(UIColor(hex: "#387440")))
//                        .cornerRadius(8)
                    }
                    .padding()
                    .background(Color(UIColor(hex: "#ddedb6")))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(UIColor(hex: "#ddedb6")), lineWidth: 1)
                    )

                    // Search bar for products
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
                    .frame(width: 250, height: 20)
                    .padding(.vertical)

                    LazyVGrid(columns: columns) {
                        ForEach(filteredItems, id: \.id) { item in
                            MenuItemView(billId: billId, product: item)
                                .frame(width: itemSize.width, height: itemSize.height)
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(color:Color(UIColor(hex: "#387440")),radius: 2)
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                fetchBillDetails()
            }
        }
        .background(
            NavigationLink(destination: BillDetailsView(viewModel: BillDetailsViewModel(itemId: billId)), isActive: $navigateToBillDetails) {
                EmptyView()
            }
        )
        
        // Button to navigate to Bill Details
        Button("View Bill Details") {
            navigateToBillDetails = true
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(UIColor(hex: "#387440")))
        .cornerRadius(8)
        .padding([.horizontal, .bottom])
    }

    // Function to fetch bill details
    private func fetchBillDetails() {
        Firestore.firestore().collection("bills").document(billId).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                self.table = data?["table"] as? String ?? ""
                self.owner = data?["owner"] as? String ?? ""
            } else {
                print("Document does not exist")
            }
        }
    }

    // Function to update bill details
    private func updateBillDetails() {
        let billRef = Firestore.firestore().collection("bills").document(billId)
        billRef.updateData([
            "table": table,
            "owner": owner
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
}
