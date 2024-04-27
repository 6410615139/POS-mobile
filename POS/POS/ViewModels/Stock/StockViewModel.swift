//
//  StockViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 9/4/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class StockViewModel: ObservableObject {
    @Published var showingnewProductView = false
    @Published var products: [Product] = []
    
    private var db = Firestore.firestore()
    
    func sort_product() {
        products.sort { $0.product_name > $1.product_name }
    }
    
    func updateProduct(_ product: Product) {
        db.collection("products").document(product.id).updateData(product.toDictionary()) { error in
            if let error = error {
                print("Error updating product: \(error.localizedDescription)")
            } else {
                print("Product successfully updated")
            }
        }
    }
    
    func deleteProduct(productId: String) {
        db.collection("products").document(productId).delete { error in
            if let error = error {
                print("Error deleting order: \(error)")
            } else {
                self.products.removeAll(where: { $0.id == productId })
            }
        }
    }
    
    
}
