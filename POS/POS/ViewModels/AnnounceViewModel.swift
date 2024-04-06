//
//  AnnounceViewModel.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AnnounceViewModel: ObservableObject {
    @Published var showingnewPostView = false
    @Published var posts: [Post] = []

    func fetchPosts() async {
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection("post").getDocuments()
            let fetchedPosts = snapshot.documents.compactMap { document in
                try? document.data(as: Post.self)
            }
            // Switch to the main thread to update the published property
            DispatchQueue.main.async {
                self.posts = fetchedPosts
                self.sortPost()
            }
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
    
    func sortPost() {
        posts.sort { $0.createDate > $1.createDate }
    }
}
