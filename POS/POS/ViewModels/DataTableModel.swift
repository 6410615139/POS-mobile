//
//  DataTableModel.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 5/4/2567 BE.
//

import Foundation
import FirebaseFirestore

class DataTableModel: ObservableObject {
    @Published var users = [User]()

    private var db = Firestore.firestore()

    func fetchUsers() {
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.users = querySnapshot?.documents.compactMap { document -> User? in
                    try? document.data(as: User.self)
                } ?? []
            }
        }
    }
}
