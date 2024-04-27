//
//  CommentView.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 6/4/2567 BE.
//

import SwiftUI

struct CommentView: View {
    @StateObject private var viewModel: CommentViewModel
    let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
        _viewModel = StateObject(wrappedValue: CommentViewModel(authorId: comment.authorId))
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .shadow(color: Color(UIColor(hex: "#ddedb6")), radius: 2, x: 0, y: 3)
            VStack(alignment: .leading) {
                Text(viewModel.authorName.isEmpty ? "Loading..." : viewModel.authorName)
                    .font(.caption)
                    .bold()
                Text("Comment on \(viewModel.formattedDate(for: comment.timestamp))")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(comment.content)
                    .font(.body)
            }.padding()
            
        }
    }
}


#Preview {
    CommentView(comment: Comment(id: "1", authorId: "123", content: "Sample comment", timestamp: 1609459200))
}
