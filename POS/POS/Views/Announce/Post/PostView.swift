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
    @State private var showConfigMenu = false
    @State private var showingEditView = false
    @State private var showingDeleteAlert = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        ScrollView {
            if let post = viewModel.post {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(post.title)
                            .font(.title)
                            .bold()
                        Spacer()
                        
                        if viewModel.currentUserIsCreator {
                            configButton
                        }
                    }
                    
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
                            showingLikedUsers = true
                        }) {
                            HStack {
                                Image(systemName: "heart.circle.fill").foregroundColor(.red)
                                Text("\(viewModel.likeCount)")
                            }
                        }
                        .sheet(isPresented: $showingLikedUsers) {
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
        .sheet(isPresented: $showingEditView) {
            EditPostView(post: $viewModel.post, onCommit: { newTitle, newContent in
                viewModel.editPost(newTitle: newTitle, newContent: newContent)
            })
        }
        .navigationBarTitle("Post Details", displayMode: .inline)
    }
    
    private var configButton: some View {
        Button(action: {
            self.showConfigMenu = true
        }) {
            Image(systemName: "ellipsis.circle")
                .imageScale(.large)
        }
        .actionSheet(isPresented: $showConfigMenu) {
            ActionSheet(
                title: Text("Options"),
                buttons: [
                    .default(Text("Edit")) {
                        self.showingEditView = true
                    },
                    .destructive(Text("Delete")) {
                        self.showingDeleteAlert = true
                    },
                    .cancel()
                ]
            )
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Are you sure you want to delete this post?"),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Delete")) {
                    viewModel.deletePost()
                    // Use this to pop the current view off the navigation stack
                    self.presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
}


#Preview {
    PostView(viewModel: PostViewModel(
        postId: "F4508F27-09D6-419C-B758-9C045826489E"))
}
