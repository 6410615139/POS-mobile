//
//  BillViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 5/4/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class BillViewModel: ObservableObject {
    @Published var showingnewItemView = false
    
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("bills")
            .document(id)
            .delete()
    }
    
    func create_bill() {
        let orders = [Order]()
        let new_bill = Bill(id: UUID().uuidString, table: "10", createDate: Date().timeIntervalSince1970, orders: orders, owner: "ownerId")
        let db = Firestore.firestore()
        db.collection("bills")
            .document(String(new_bill.id))
            .setData(new_bill.asDictionary())
        BillDetailsView(itemId: String(new_bill.id))
    }
}
