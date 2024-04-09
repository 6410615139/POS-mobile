//
//  LoginView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "POS", subtitle: "Point of Sale", angle: 15, background: .pink)
                
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    POSButton(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                }
                VStack {
                    Text("Hello")
                    NavigationLink("Create an Account", destination:
                        RegisterView())
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
