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
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    private let itemSize: CGSize = CGSize(width: 150, height: 150)

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
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Table")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Table Number", text: $table)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        VStack(alignment: .leading) {
                            Text("Owner")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            TextField("Owner's Name", text: $owner)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding()

                    // Search bar for products
                    TextField("Search Products...", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    // Button to update bill details
                    Button("Update Bill Details") {
                        updateBillDetails()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    // Button to navigate to Bill Details
                    Button("View Bill Details") {
                        navigateToBillDetails = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredItems, id: \.id) { item in
                            MenuItemView(billId: billId, product: item)
                                .frame(width: itemSize.width, height: itemSize.height)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle("Order", displayMode: .inline)
            .onAppear {
                fetchBillDetails()
            }
        }
        .background(
            NavigationLink(destination: BillDetailsView(viewModel: BillDetailsViewModel(itemId: billId)), isActive: $navigateToBillDetails) {
                EmptyView()
            }
        )
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
