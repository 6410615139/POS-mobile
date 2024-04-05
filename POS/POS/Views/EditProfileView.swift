//
//  EditProfileView.swift
//  POS
//
//  Created by ชลิศา ธรรมราช on 2/4/2567 BE.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let user = viewModel.user {
            Form {
                HStack{
                    Text("Email:")
                    Text(user.email)
                }
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Telephone", text: $viewModel.tel)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                POSButton(title: "Save", background: .green) {
                    viewModel.edit()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .onAppear{
                    viewModel.load()
                }
            }
            .offset(y: -50)

        } else {
            Text("Loading")
        }
    }
}

#Preview {
    EditProfileView()
}

