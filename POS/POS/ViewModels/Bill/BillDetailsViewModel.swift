//
//  BillDetailsViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class BillDetailsViewModel: ObservableObject {
    var itemId: String
    @Published var item: Bill? = nil
    @Published var showingEditView = false
    @Published var orders: [Order]? = []
    @Published var totalString: String = "0"
    
    private var db = Firestore.firestore()

    init(itemId: String) {
        self.itemId = itemId
        fetch_item()
        fetchOrders()
    }
    
    func fetch_item() {
        self.calculateTotal()
        db.collection("bills").document(itemId).getDocument { [weak self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.item = Bill(
                    id: data["id"] as? String ?? "",
                    table: data["table"] as? String ?? "",
                    createDate: data["createDate"] as? TimeInterval ?? 0,
                    orders: data["orders"] as? [Order] ?? [],
                    owner: data["owner"] as? String ?? "", 
                    status: data["status"] as? Bool ?? false
                )
                self?.fetchOrders()  // Ensure orders are updated after bill fetch
            }
        }
    }

    func updateOrder(order: Order, in billId: String) {
        let db = Firestore.firestore()
        let orderRef = db.collection("bills").document(billId).collection("orders").document(order.id)

        // Prepare the data dictionary to update only the 'amount' field
        let updateData = ["amount": order.amount]

        orderRef.updateData(updateData) { error in
            if let error = error {
                print("Error updating order: \(error.localizedDescription)")
            } else {
                print("Order successfully updated")
            }
        }
        // Optionally, fetch orders again to refresh the data
        self.fetchOrders()
    }
    
    func updateBillStatus(value: Bool) {
        let db = Firestore.firestore()
        let orderRef = db.collection("bills").document(itemId)

        // Prepare the data dictionary to update only the 'amount' field
        let updateData = ["status": value]

        orderRef.updateData(updateData) { error in
            if let error = error {
                print("Error updating order: \(error.localizedDescription)")
            } else {
                print("Order successfully updated")
            }
        }
        // Optionally, fetch orders again to refresh the data
        self.fetchOrders()
    }

    func deleteOrder(orderId: String) {
        db.collection("bills").document(itemId).collection("orders").document(orderId).delete { error in
            if let error = error {
                print("Error deleting order: \(error)")
            } else {
                self.orders?.removeAll(where: { $0.id == orderId })
            }
        }
    }

    func fetchOrders() {
        db.collection("bills").document(itemId).collection("orders").getDocuments { [weak self] snapshot, error in
            if let documents = snapshot?.documents {
                self?.orders = documents.compactMap { try? $0.data(as: Order.self) }
            } else if let error = error {
                print("Error fetching orders: \(error)")
            }
        }
        self.calculateTotal()
    }
    
    private func calculateTotal() {
        guard let orders = orders else {
            self.totalString = "0"
            return
        }
        let total = orders.reduce(0) { (result, order) -> Double in
            // Assuming each order contains a 'price' field and you need to multiply by 'amount'
            // Adjust calculation as necessary based on your actual data model
            return result + (Double(order.amount) * (order.product.price ?? 0.0))
        }
        // Format the total as a string suitable for display
        self.totalString = String(format: "%.2f", total)
    }
}
