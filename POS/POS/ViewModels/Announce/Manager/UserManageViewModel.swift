//
//  UserManageViewModel.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 21/4/2567 BE.
//

import Foundation
import FirebaseFirestore

class UserManageViewModel: ObservableObject {
    @Published var timeRecords: [TimeRecord] = []
    
    private let db = Firestore.firestore()
    private var userId: String?
    
    func loadUserData(for user: User) {
        self.userId = user.id
        fetchTimeRecords()
    }
    
    func fetchTimeRecords() {
        guard let userId = self.userId else { return }
        
        db.collection("users").document(userId).collection("timeRecord")
            .order(by: "clockInTime", descending: true)
            .getDocuments { [weak self] (querySnapshot, error) in
                if let documents = querySnapshot?.documents {
                    self?.timeRecords = documents.compactMap { document in
                        try? document.data(as: TimeRecord.self)
                    }
                } else if let error = error {
                    print("Error fetching time records: \(error)")
                }
            }
    }
    
    func updateUserDetail(_ user: User, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = user.id else {
            completion(false, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"]))
            return
        }
        
        db.collection("users").document(userId).setData(user.asDictionary()) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
