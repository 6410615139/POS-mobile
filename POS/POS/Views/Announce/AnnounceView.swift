//
//  AnnounceView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct AnnounceView: View {
    @StateObject var viewModel = AnnounceViewModel()
    var user: User
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing){
                VStack {
                    List(viewModel.posts, id: \.id) { post in
                        NavigationLink(destination: PostView(viewModel: PostViewModel(postId: post.id))) {
                            AnnounceItemView(item: post)
                        }
                        .padding()
                        .background(Color.white) // Use your actual background color
                        .border(Color(UIColor(hex: "#ddedb6")), width: 7)
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationTitle("Announcements")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if user.role.isOwner || user.role.isManager {
                            HStack {
                                Text("Manage Staff")
                                Button(action: {
                                    viewModel.showingManageStaffView = true
                                }) {
                                    Image(systemName: "gearshape")
                                        .foregroundColor(Color(UIColor(hex: "#387440")))
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $viewModel.showingnewPostView) {
                    NewPostView(newPostPresented: $viewModel.showingnewPostView)
                }
                .sheet(isPresented: $viewModel.showingManageStaffView) {
                    ManageView()
                }
                .onAppear {
                    Task {
                        await viewModel.fetchPosts()
                    }
                }
                .onChange(of: viewModel.showingnewPostView) {
                    if !viewModel.showingnewPostView {
                        Task {
                            await viewModel.fetchPosts()
                        }
                    }
                }
                VStack{
                    Button(action: {
                        viewModel.showingnewPostView = true
                    }) {
                        Image(systemName: "square.and.pencil.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundColor(Color(UIColor(hex: "#387440")))
                    }
                    .padding()
                }
            }
        }
    }
}

// Formatter for displaying the post's creation date
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

#Preview {
    AnnounceView(user: .init(id: "123", name: "John", email: "john@mail.com", tel: "0812345643", gender: .male, joined: Date().timeIntervalSince1970, role: .manager))
}
