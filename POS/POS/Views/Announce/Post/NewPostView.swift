//
//  NewPostView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct NewPostView: View {
    
    @StateObject var viewModel = NewPostViewModel()
    @StateObject var HomeviewModel = AnnounceViewModel()
    @Binding var newPostPresented: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Text("Create Post")
                    .font(.system(size: 32))
                    .bold()
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                POSButton(title: "POST", background: Color(UIColor(hex: "#387440"))) {
                    viewModel.save()
                    newPostPresented = false
                }
                .frame(maxWidth: 80, maxHeight: 45)
                .padding(.horizontal)
            }
            Form {
                TextField("Title", text: $viewModel.title)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                ZStack(alignment: .topLeading) {
                    if viewModel.content.isEmpty {
                        Text("Content")
                            .foregroundColor(Color(UIColor(hex: "#CBCBCB")))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                    }
                    TextEditor(text: $viewModel.content)
                        .frame(height: 500)
                        .textFieldStyle(DefaultTextFieldStyle())
                    }
                    .animation(.default, value: viewModel.content.isEmpty)
               
            }
            
        }
    }
}

#Preview {
    NewPostView(newPostPresented: .constant(true))
}
