//
//  NewPostView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct NewPostView: View {
    
    @StateObject var viewModel = NewPostViewModel()
    @Binding var newPostPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Item")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Content", text: $viewModel.content)
                    .textFieldStyle(DefaultTextFieldStyle())
                POSButton(title: "Save", background: .pink) {
                    viewModel.save()
                    newPostPresented = false
                }
            }
            
        }
    }
}

#Preview {
    NewPostView(newPostPresented: .constant(true))
}
