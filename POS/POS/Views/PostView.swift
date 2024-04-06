//
//  PostView.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 6/4/2567 BE.
//

import SwiftUI

struct PostView: View {
    @ObservedObject var viewModel: PostViewModel
    @State private var newCommentText: String = ""
    
    var body: some View {
        ScrollView {
            if let post = viewModel.post {
                VStack(alignment: .leading, spacing: 10) {
                    Text(post.title)
                        .font(.title)
                        .bold()
                    
                    Text("Posted on \(viewModel.formattedCreateDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(post.content)
                        .font(.body)
                    
                    
                    // Comments Section Title
                    Text("Comments")
                        .font(.headline)
                        .padding(.vertical)
                    
                    // Displaying each comment
                    ForEach(post.comments, id: \.id) { comment in
                        VStack(alignment: .leading) {
                            Text(comment.authorId)  // Ideally, you would fetch the author's name using this ID.
                                .font(.caption)
                                .bold()
                            Text(comment.content)
                                .font(.body)
                            Text("Posted on \(viewModel.formattedDate(for: comment.timestamp))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.bottom)
                    }
                    
                    // Comment Input Field
                    TextField("Add a comment...", text: $newCommentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                    
                    // Submit Button
                    Button("Submit") {
                        // Assuming you have a method to get the current user's ID
                        let authorId = "CurrentUser"  // Replace this with actual user ID retrieval logic
                        viewModel.comment(authorId: authorId, content: newCommentText)
                        newCommentText = ""
                    }
                    .buttonStyle(.bordered)
                    
                }
                .padding()
            } else {
                Text("Loading post...")
                    .font(.headline)
            }
        }
        .navigationBarTitle("Post Details", displayMode: .inline)
    }
}


#Preview {
    PostView(viewModel: PostViewModel(postId: "12E1E8EF-E114-4CE2-9BB5-4ECC57073FFD"))
}
