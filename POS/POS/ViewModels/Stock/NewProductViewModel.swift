//
//  NewProductViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewProductViewModel: ObservableObject {
    @Published var product_name = ""
    @Published var price: Double = 0.0
    @Published var amount: Int = 0
    
    func save() {
        guard let uId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        let newId = UUID().uuidString
        let new_product = Product(id: newId, product_name: product_name, price: price, amount: amount)
        let db = Firestore.firestore()
        
        db.collection("products")
            .document(newId)
            .setData(new_product.asDictionary()) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            }
    }

}
