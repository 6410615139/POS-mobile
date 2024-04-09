//
//  RegisterView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    let gender = ["Female", "Male", "LGBTQ"]
    
    var body: some View {
        VStack {
            HeaderView(title: "Register", subtitle: "Start organizing POS", angle: -15, background: .orange)
            Form {
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                TextField("Telephone", text: $viewModel.tel)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Picker("Gender", selection: $viewModel.gender) {
                    ForEach(gender, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                
                POSButton(title: "Create Account", background: .green) {
                    viewModel.register()
                }
            }
            .offset(y: -50)
            
            Spacer()
            
        }
    }
}

#Preview {
    RegisterView()
}
