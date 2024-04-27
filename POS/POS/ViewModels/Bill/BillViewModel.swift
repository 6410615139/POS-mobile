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
    @Published var newBillId: String = ""
    
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("bills")
            .document(id)
            .delete()
    }
    
    func create_bill() {
        let orders = [Order]()
        let newId = UUID().uuidString
        let new_bill = Bill(id: newId, table: "0", createDate: Date().timeIntervalSince1970, orders: orders, owner: "-", status: false)
        let db = Firestore.firestore()
        db.collection("bills")
            .document(String(new_bill.id))
            .setData(new_bill.asDictionary())
        self.newBillId = newId
    }
}
