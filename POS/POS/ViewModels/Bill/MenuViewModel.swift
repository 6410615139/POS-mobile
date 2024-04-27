//
//  MenuViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class MenuViewModel: ObservableObject {
    @Published var showingnewItemView = false
    
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("products")
            .document(id)
            .delete()
    }
    
    func create_product(product_name: String, details: String, price: Double, image_path: String, catagory: String, amount: Int) {
        let orders = [Order]()
        let new_product = Product(id: UUID().uuidString, product_name: product_name, price: price, amount: amount)
        let db = Firestore.firestore()
        db.collection("products")
            .document(String(new_product.id))
            .setData(new_product.asDictionary())
    }
}
