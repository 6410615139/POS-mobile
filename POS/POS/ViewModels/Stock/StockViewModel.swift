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
    
    func fetchPosts() async {
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection("products").getDocuments()
            let fetched_products = snapshot.documents.compactMap { document in
                try? document.data(as: Product.self)
            }
            // Switch to the main thread to update the published property
            DispatchQueue.main.async {
                self.products = fetched_products
                self.sort_product()
            }
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
    
    func sort_product() {
        products.sort { $0.product_name > $1.product_name }
    }
    
    func fetchUserName(uid: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { (document, error) in
            if let document = document, document.exists {
                let name = document.data()?["name"] as? String
                completion(name)
            } else {
                print("User not found or error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
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
