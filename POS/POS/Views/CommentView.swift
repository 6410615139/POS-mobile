//
//  CommentView.swift
//  POS
//
//  Created by Thammasat Thonggamgaew on 6/4/2567 BE.
//

import SwiftUI

struct CommentView: View {
    let comment: Comment
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(comment.authorId)
                .font(.caption)
                .bold()
            Text(comment.content)
                .font(.body)
            Text("Posted on \(formattedDate(for: comment.timestamp))")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.bottom)
    }
    
    func formattedDate(for timestamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}


#Preview {
    CommentView(comment: Comment(id:"DB41CEC0-4A1B-4B08-9824-3403754D8BA6", authorId: "Lj2XtHePXoP5x2vT8o5jlsMEWxm2", content: "Pnawrgawrgpijawrgpijawrpg", timestamp: 1712410176.4621701))
}
