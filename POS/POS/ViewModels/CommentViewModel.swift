//
//  CommentViewModel.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 6/4/2567 BE.
//

import Combine
import FirebaseFirestore

class CommentViewModel: ObservableObject {
    @Published var comment: Comment?
    
    init(postId: String) {
        fetchComment(postId: postId)
    }
    
    func fetchComment(postId: String) {
        let db = Firestore.firestore()
        let docRef = db.collection("post").document(postId)
        
        docRef.getDocument { (snapshot, error) in
            if let document = snapshot, document.exists {
                do {
                    self.comment = try document.data(as: Comment.self)
                } catch {
                    print("Error decoding post: \(error)")
                }
            } else {
                print("Document does not exist: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func formattedDate(for timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
