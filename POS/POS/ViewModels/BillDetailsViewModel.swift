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
    
    init(itemId: String) {
        self.itemId = itemId
        fetch_item()
    }
    
    func fetch_item() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("bills")
            .document(itemId)
            .getDocument { [weak self]snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.item = Bill(
                        id: data["id"] as? String ?? "",
                        table: data["table"] as? String ?? "",
                        createDate: data["createDate"] as? TimeInterval ?? 0,
                        orders: data["orders"] as? [Order] ?? [],
                        owner: data["owner"] as? String ?? ""
                    )
                }
                
            }
    }
}
