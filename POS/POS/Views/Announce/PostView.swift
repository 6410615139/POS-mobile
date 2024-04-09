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
                    
                    Button(action: {
                        viewModel.likePost()
                    }) {
                        HStack {
                            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.isLiked ? .red : .gray)
                            Text("Like (\(viewModel.likeCount))")
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
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
    PostView(viewModel: PostViewModel(
        postId: "259859B2-0BA8-48B8-8042-6C9A918B28DD"))
}
