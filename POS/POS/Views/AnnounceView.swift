//
//  AnnounceView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct AnnounceView: View {
    @StateObject var viewModel = AnnounceViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .font(.headline)
                        Text(post.content)
                            .font(.subheadline)
                        Text("Created at: \(Date(timeIntervalSince1970: post.createDate), formatter: itemFormatter)")
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Announcements")
            .toolbar {
                Button {
                    viewModel.showingnewPostView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingnewPostView) {
                NewPostView(newPostPresented: $viewModel.showingnewPostView)
            }
            .onAppear {
                Task {
                    await viewModel.fetchPosts()
                }
            }
            .onChange(of: viewModel.showingnewPostView) { newValue in
                if !newValue { // When the sheet is dismissed
                    Task {
                        await viewModel.fetchPosts()
                    }
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
    AnnounceView()
}
