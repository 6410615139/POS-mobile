//
//  LoginView.swift
//  POS
//
//  Created by Supakrit Nithikethkul on 11/3/2567 BE.
//

import SwiftUI

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "POS", subtitle: "Point of Sale", angle: 15, background: .pink)
                
                Form {
                    TextField("Email Address", text: $email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    SecureField("Password", text: $password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    POSButton(title: "Log In", background: .blue) {
                        
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
