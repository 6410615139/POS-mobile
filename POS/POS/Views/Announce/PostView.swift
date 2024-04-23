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
    @State private var showingLikedUsers = false
    
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
                    
                    // Like Button
                    Button(action: {
                        viewModel.toggleLike()
                    }) {
                        HStack {
                            Image(systemName: viewModel.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(viewModel.isLiked ? .red : .gray)
                            Text("Like")
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    // Like count and liked user list
                    if !viewModel.post!.likes.isEmpty {
                        Button(action: {
                            showingLikedUsers = true  // Set to true to show the sheet
                        }) {
                            HStack {
                                Image(systemName: "heart.circle.fill").foregroundColor(.red)
                                Text("\(viewModel.likeCount)")
                            }
                        }
                        // Use .sheet here within the body of a view
                        .sheet(isPresented: $showingLikedUsers) {
                            // Present the LikedUsersView as the content of the sheet
                            LikedUsersView(likes: viewModel.post!.likes)
                        }
                    }
                    
                    
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
        postId: "896F3AC2-BC69-4411-BB3E-A29B0EFFF633"))
}
