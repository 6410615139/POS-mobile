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
//    @State private var userName: String = ""
    
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
                    
                    
                    // Comments Section
                    Text("Comments")
                        .font(.headline)
                        .padding(.vertical)
                    
                    ForEach(post.comments, id: \.id) { comment in
                        VStack(alignment: .leading) {
                            CommentView(comment: comment)
                        }
                        .padding(.bottom)
                    }

                    // Comment Input Field
                    TextField("Add a comment...", text: $newCommentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                    
                    // Submit Button
                    Button("Submit") {
                        viewModel.comment(content: newCommentText)
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
    PostView(viewModel: PostViewModel(postId: "F1797756-E9BB-4582-8C29-658557F07FE0"))
}
