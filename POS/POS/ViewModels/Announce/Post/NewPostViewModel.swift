//
//  NewPostViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewPostViewModel: ObservableObject {
    @Published var title = ""
    @Published var createDate = Date()
    @Published var content = ""
    
    func save() {
        guard let uId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }

        let newId = UUID().uuidString
        let newPost = Post(id: newId, title: title, createDate: Date().timeIntervalSince1970, content: content, creator: uId, comments: [], likes: [])
        let db = Firestore.firestore()
        
        db.collection("post")
            .document(newId)
            .setData(newPost.asDictionary()) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            }
    }

}
