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
//    @Published var owner = ""
    
    func save() {
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newPost = Post(id: newId, title: title, createDate: Date().timeIntervalSince1970, content: content, creator: uId)
        let db = Firestore.firestore()
        db.collection("post")
            .document(newId)
            .setData(newPost.asDictionary())
    }
}
