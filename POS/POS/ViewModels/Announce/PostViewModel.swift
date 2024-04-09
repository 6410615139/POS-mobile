//
//  PostViewModel.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 6/4/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class PostViewModel: ObservableObject {
    @Published var post: Post?
    
    init(postId: String) {
        fetchPost(postId: postId)
    }
    
    
    // Post section
    var formattedCreateDate: String {
        guard let postDate = post?.createDate else { return "" }
        let date = Date(timeIntervalSince1970: postDate)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    // Comment section
    func formattedDate(for timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
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
    
    func comment(content: String) {
        guard let postId = self.post?.id else {
            print("Post ID is unavailable.")
            return
        }
        
        guard let uId = Auth.auth().currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        let db = Firestore.firestore()
        let postRef = db.collection("post").document(postId)
        let newComment = Comment(id: UUID().uuidString, authorId: uId, content: content, timestamp: Date().timeIntervalSince1970)
        
        postRef.updateData([
            "comments": FieldValue.arrayUnion([newComment.dictionary])
        ]) { error in
            if let error = error {
                print("Error adding comment: \(error.localizedDescription)")
            } else {
                print("Comment successfully added.")
                self.post?.comments.append(newComment)
            }
        }
    }
    
}
