//
//  MainViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class MainViewModel: ObservableObject {
    @Published var currentUserId = ""
    @Published var user: User?  // This will hold the fetched user data
    
    private var handler: AuthStateDidChangeListenerHandle?
    private let db = Firestore.firestore()  // Reference to Firestore
    
    init() {
        handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                if let userId = user?.uid {
                    self?.currentUserId = userId
                    self?.fetchUser(userId: userId)  // Fetch user data when user ID is available
                } else {
                    self?.currentUserId = ""
                    self?.user = nil  // Reset user data if not signed in
                }
            }
        }
    }
    
    private func fetchUser(userId: String) {
        let db = Firestore.firestore()  // Ensure Firestore instance is initialized correctly.
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            DispatchQueue.main.async {
                guard let document = document, document.exists else {
                    print("No document found: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let userData = try document.data(as: User.self)
                    self?.user = userData
                } catch {
                    print("Failed to decode user: \(error)")
                }
            }
        }
    }

    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
