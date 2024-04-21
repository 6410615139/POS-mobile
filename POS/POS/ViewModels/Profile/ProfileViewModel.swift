//
//  ProfileViewModel.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 14/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var name = ""
    @Published var tel = ""
    @Published var gender: Gender = .undefined
    @Published var role = ""
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let self = self, let snapshot = snapshot, let data = snapshot.data(), error == nil else {
                print("Error fetching user: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                self.user = try snapshot.data(as: User.self)
                self.load() // Update local properties with fetched data
            } catch {
                print("Error decoding user: \(error)")
            }
        }
    }
    
    private func validate() -> Bool {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !tel.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        guard tel.count == 10 else {
            return false
        }
        return true
    }
    
    func edit() {
        guard let uId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uId)
        
        let updatedUser = User(id: uId, name: name, email: user?.email ?? "", tel: tel, gender: gender, joined: user?.joined ?? Date().timeIntervalSince1970, role: user?.role ?? .staff)
        
        do {
            try userRef.setData(from: updatedUser) { error in
                if let error = error {
                    print("Error updating user: \(error.localizedDescription)")
                } else {
                    print("User successfully updated")
                }
            }
        } catch {
            print("Failed to encode user: \(error)")
        }
        
        // After updating the user, update the local user instance
        self.user = updatedUser
    }
    
    func load() {
        guard let currentUser = user else { return }
        name = currentUser.name
        tel = currentUser.tel
        gender = currentUser.gender // Make sure the gender is set correctly from the user data
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func deleteAccount(completion: @escaping (Bool, Error?) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false, nil)  // No user is logged in.
            return
        }
        
        let userId = user.uid
        let db = Firestore.firestore()
        
        // Delete user data from Firestore first
        db.collection("users").document(userId).delete { error in
            if let error = error {
                completion(false, error)
                return
            }
            
            // Once the user data is deleted from Firestore, delete the authentication record
            user.delete { error in
                if let error = error {
                    completion(false, error)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
}
