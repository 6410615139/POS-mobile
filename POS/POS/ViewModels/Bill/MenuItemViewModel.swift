//
//  MenuItemViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class MenuItemViewModel: ObservableObject {
    @Published var billId: String
    private var db = Firestore.firestore()

    init(billId: String) {
        self.billId = billId
    }

    func addToCart(product: Product, amount: Int) {
        let order = Order(id: UUID().uuidString, amount: amount, product: product)
        
        do {
            // Convert the order to a dictionary
            let orderData = try Firestore.Encoder().encode(order)
            
            // Add the order to the "orders" collection under the specified billId
            db.collection("bills").document(billId).collection("orders").document(order.id).setData(orderData) { error in
                if let error = error {
                    print("Error adding order: \(error)")
                } else {
                    print("Order added successfully!")
                }
            }
        } catch {
            print("Error encoding order: \(error)")
        }
    }
}
