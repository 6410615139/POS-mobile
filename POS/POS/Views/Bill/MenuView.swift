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
    @FirestoreQuery(collectionPath: "products") var items: [Product]
    @State private var billId: String
    @State private var table: String = ""
    @State private var owner: String = ""
    @State private var isBillDetailsActive = false

    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]

    private let itemSize: CGSize = CGSize(width: 150, height: 150)

    init(billId: String) {
        self._viewModel = StateObject(wrappedValue: MenuViewModel())
        self.billId = billId
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Table")
                    TextField("Enter table number", text: $table)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Text("Owner")
                    TextField("Enter owner's name", text: $owner)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Update Bill Details") {
                        updateBillDetails()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items) { item in
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
    }

    private func fetchBillDetails() {
        // Fetch the current details of the bill using the billId
        // Assume using Firestore to fetch the data and initialize table and owner
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

    private func updateBillDetails() {
        // Update the table and owner information in Firestore
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
