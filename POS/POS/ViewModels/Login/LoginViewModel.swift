//
//  LoginViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    private var db = Firestore.firestore()
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                self.recordClockIn(userId: user.uid)
            }
        }
    }
    
    private func recordClockIn(userId: String) {
        let db = Firestore.firestore()
        var newRecord = TimeRecord(id: UUID().uuidString, userId: userId, clockInTime: Date().timeIntervalSince1970, clockOutTime: nil)
        
        let userTimeRecords = db.collection("users").document(userId).collection("timeRecord")
        userTimeRecords.document(newRecord.id).setData(newRecord.asDictionary()) { error in
            if let error = error {
                print("Error writing time record to Firestore: \(error)")
            } else {
                print("Time record successfully created for user \(userId)")
            }
        }
    }


    
}
