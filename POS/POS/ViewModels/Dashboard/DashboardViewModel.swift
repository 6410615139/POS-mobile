//
//  DashboardViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 27/4/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class DashboardViewModel: ObservableObject {
    @Published var totalSales: Double = 0.0
    @Published var bestSellerProduct: Product?
    private var orders: [Order]? = []

    private var db = Firestore.firestore()

    init() {
        print("ViewModel initialized, fetching bills...")
        self.fetchBills()
    }

    func fetchBills() {
        db.collection("bills").getDocuments { [weak self] (snapshot, error) in
            guard let self = self else {
                print("Reference to self lost, exiting fetch.")
                return
            }
            if let error = error {
                print("Error fetching bills: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("No documents found or snapshot is nil.")
                return
            }

            print("Processing \(documents.count) bills...")
            let allBills = documents.compactMap { doc -> Bill? in
                let bill = try? doc.data(as: Bill.self)
                if bill == nil { print("Failed to decode bill for document \(doc.documentID)") }
                return bill
            }
            self.computeTotalSales(bills: allBills)
            self.findBestSeller(bills: allBills)
        }
    }
    
    func fetchOrders(for itemId: String, completion: @escaping ([Order]) -> Void) {
        db.collection("bills").document(itemId).collection("orders").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching orders: \(error)")
                completion([])
            } else if let documents = snapshot?.documents {
                let orders = documents.compactMap { try? $0.data(as: Order.self) }
                completion(orders)
            } else {
                completion([])
            }
        }
    }
    
    private func computeTotalSales(bills: [Bill]) {
        let group = DispatchGroup()
        var paidBills = bills.filter { $0.status }

        // Fetch orders for each paid bill asynchronously
        for index in paidBills.indices {
            group.enter()
            fetchOrders(for: paidBills[index].id) { orders in
                paidBills[index].orders = orders
                group.leave()
            }
        }

        // After all orders have been fetched, compute the total sales
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            let total = paidBills.reduce(0) { (result, bill) -> Double in
                let billTotal = bill.orders.reduce(0) { (subtotal, order) -> Double in
                    return subtotal + (Double(order.amount) * order.product.price)
                }
                return result + billTotal
            }

            DispatchQueue.main.async {
                print("Total sales computed for paid bills: \(total)")
                self.totalSales = total
            }
        }
    }

    private func findBestSeller(bills: [Bill]) {
        let group = DispatchGroup()
        var allOrders: [Order] = []

        // Collect all orders from paid bills
        for bill in bills where bill.status {
            group.enter()
            fetchOrders(for: bill.id) { orders in
                DispatchQueue.main.async {
                    allOrders.append(contentsOf: orders)
                    group.leave()
                }
            }
        }

        // Compute the best seller once all orders have been fetched
        group.notify(queue: DispatchQueue.global(qos: .background)) {
            var productCounts = [String: (product: Product, count: Int)]()

            // Tally counts for each product
            for order in allOrders {
                let key = order.product.id
                if let existing = productCounts[key] {
                    productCounts[key] = (order.product, existing.count + order.amount)
                } else {
                    productCounts[key] = (order.product, order.amount)
                }
            }

            // Determine which product had the highest count
            let bestSeller = productCounts.max { a, b in a.value.count < b.value.count }
            DispatchQueue.main.async {
                print("Best seller identified: \(bestSeller?.value.product.product_name ?? "None")")
                self.bestSellerProduct = bestSeller?.value.product
            }
        }
    }
}
