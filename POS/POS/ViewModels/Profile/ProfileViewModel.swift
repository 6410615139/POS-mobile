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
    @Published var timeRecords: [TimeRecord] = []
    
    init() {
        fetchUser()
        fetchTimeRecords()
    }
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            guard let self = self, let snapshot = snapshot, let _ = snapshot.data(), error == nil else {
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
    
    func fetchTimeRecords() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).collection("timeRecord")
            .order(by: "clockInTime", descending: true)
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching time records: \(error)")
                } else {
                    self?.timeRecords = querySnapshot?.documents.compactMap {
                        try? $0.data(as: TimeRecord.self)
                    } ?? []
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
        if let userId = Auth.auth().currentUser?.uid {
            recordClockOut(userId: userId)
            
            do {
                try Auth.auth().signOut()
                print("User logged out successfully.")
            } catch {
                print("Logout error: \(error)")
            }
        }
    }
    
    private func recordClockOut(userId: String) {
        let db = Firestore.firestore()
        let userTimeRecords = db.collection("users").document(userId).collection("timeRecord")
        // We assume that there should be only one active session, thus we get the last clocked in record
        userTimeRecords.order(by: "clockInTime", descending: true).limit(to: 1).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else if let querySnapshot = querySnapshot, !querySnapshot.documents.isEmpty {
                let document = querySnapshot.documents.first
                if document?.data()["clockOutTime"] == nil {
                    // Document has no clockOutTime, proceed to update
                    userTimeRecords.document(document!.documentID).updateData([
                        "clockOutTime": Date().timeIntervalSince1970
                    ], completion: { error in
                        if let error = error {
                            print("Error updating time record: \(error)")
                        } else {
                            print("Time record successfully updated for user \(userId)")
                        }
                    })
                } else {
                    print("Session already clocked out.")
                }
            } else {
                print("No active sessions found to clock out.")
            }
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
