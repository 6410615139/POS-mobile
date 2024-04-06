//
//  PostViewModel.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 6/4/2567 BE.
//

import Foundation
import FirebaseFirestore

class PostViewModel: ObservableObject {
    @Published var post: Post?

    init(postId: String) {
        fetchPost(postId: postId)
    }
    
    func fetchPost(postId: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("post").document(postId)

        docRef.getDocument { (snapshot, error) in
            if let document = snapshot, document.exists {
                do {
                    self.post = try document.data(as: Post.self)
                } catch {
                    print("Error decoding post: \(error)")
                }
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    var formattedCreateDate: String {
        guard let postDate = post?.createDate else { return "" }
        let date = Date(timeIntervalSince1970: postDate)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
