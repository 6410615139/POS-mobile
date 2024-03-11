//
//  HomeViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    @Published var showingnewPostView = false
    @Published var posts: [Post] = []
    
    func fetchPosts() async {
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection("post").getDocuments()
            self.posts = snapshot.documents.compactMap { document in
                try? document.data(as: Post.self)
            }
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
}
